//
//  GameScene.swift
//  FlappyFelippe
//
//  Created by Imrul Kayes on 2/12/18.
//  Copyright © 2018 Imrul Kayes. All rights reserved.
//

import SpriteKit
import GameplayKit

enum Layer: CGFloat {
    case Backgound
    case Obstacle
    case Foreground
    case Player
}

struct PhysicsCategory {
    static let None: UInt32 =       0       //0
    static let Player: UInt32 =     0b1     //1
    static let Obstacle: UInt32 =   0b10    //2
    static let Ground: UInt32 =     0b100   //4
    
}
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let worldNode = SKNode()
    
    var playableStart:CGFloat = 0.0
    var playableHeight:CGFloat = 0.0
    
    let numberOfForegrounds = 2
    let groundSpeed:CGFloat = 150.0
    
    var deltaTime:TimeInterval = 0
    var lastUpdateTimeInterval:TimeInterval = 0
    
    let player = Player(imageName: "Bird0")
    
    let bottomObstacleMinFraction:CGFloat = 0.1
    let bottomObstacleMaxFraction:CGFloat = 0.6
    
    let gapMultiplier:CGFloat = 3.5
    
    let firstSpawnDelay:TimeInterval = 1.75
    let everySpawnDelay:TimeInterval = 1.5
    
    //MARK: SetUp Game Machine
    lazy var gameState: GKStateMachine = GKStateMachine(states: [
        PlayingState(scene: self),
        FallingState(scene: self),
        GameOverState(scene: self)
        ])
    
    let popAction = SKAction.playSoundFileNamed("pop.wav", waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        addChild(worldNode)
        setUpBackground()
        setUpForeground()
        setUpPlayer()
        
//        startSpawning()
        
        gameState.enter(PlayingState.self)
    }
    
    //MARK: - SetUp Methods
   
    func setUpBackground() {
        let backGround = SKSpriteNode(imageNamed: "Background")
        backGround.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        backGround.position = CGPoint(x: size.width/2, y: size.height)
        backGround.zPosition = Layer.Backgound.rawValue
        worldNode.addChild(backGround)
        
        playableStart = size.height - backGround.size.height
        playableHeight = backGround.size.height
        
        let lowerLeft = CGPoint(x: 0, y: playableStart)
        let lowerRight = CGPoint(x: size.width, y: playableStart)
        
        // Add Physics
        physicsBody = SKPhysicsBody(edgeFrom: lowerLeft, to: lowerRight)
        physicsBody?.categoryBitMask = PhysicsCategory.Ground
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = PhysicsCategory.Player
    }
    
    func setUpForeground() {
        
        for i in 0..<numberOfForegrounds {
            let foreground = SKSpriteNode(imageNamed: "Ground")
            foreground.anchorPoint = CGPoint(x: 0.0, y: 1.0)
            foreground.position = CGPoint(x: CGFloat(i) * size.width, y: playableStart)
            foreground.zPosition = Layer.Foreground.rawValue
            foreground.name = "foreground"
            worldNode.addChild(foreground)
        }
    }
    
    func setUpPlayer() {
        let playerNode = player.spriteComponent.node
        playerNode.position = CGPoint(x: size.width * 0.2, y: playableHeight * 0.4 + playableStart)
        playerNode.zPosition = Layer.Player.rawValue
        worldNode.addChild(playerNode)
        
        player.movementComponent.playableStart = playableStart
    }
    
    func startSpawning() {
        let firstDelay = SKAction.wait(forDuration: firstSpawnDelay)
        let spawn = SKAction.run(spawnObstacle)
        let everyDelay = SKAction.wait(forDuration: everySpawnDelay)
        
        let spawnSequence = SKAction.sequence([spawn, everyDelay])
        let forEverSpawn = SKAction.repeatForever(spawnSequence)
        let overallSequence = SKAction.sequence([firstDelay, forEverSpawn])
        
//        run(overallSequence)
        run(overallSequence, withKey: "spawn")
    }
    
    //create a method to stop everything
    func stopSpawning() {
        removeAction(forKey: "spawn")
        worldNode.enumerateChildNodes(withName: "obstacle") { (node, stop) in
            node.removeAllActions()
        }
    }
    
    func createObstacle() -> SKSpriteNode {
        let obstacle = Obstacle(imageName: "Cactus")
        let obstacleNode = obstacle.spriteComponent.node
        obstacleNode.zPosition = Layer.Obstacle.rawValue
        obstacleNode.name = "obstacle"
        return obstacle.spriteComponent.node
    }
    
    func spawnObstacle() {
        //Bottom Obstacle
        let bottomObstacle = createObstacle()
        let startX = size.width + bottomObstacle.size.width/2
        
        let bottomObstacleMin = (playableStart - bottomObstacle.size.height/2) + playableHeight * bottomObstacleMinFraction
        let bottomObstacleMax = (playableStart - bottomObstacle.size.height/2) + playableHeight * bottomObstacleMaxFraction
        
        //let randomValue = CGFloat.random(min: bottomObstacleMin, max: bottomObstacleMax)
        
        //Using GamePlayKit's randomization
        let randomSource = GKARC4RandomSource()
        let randomDistribution = GKRandomDistribution(randomSource: randomSource, lowestValue: Int(round(bottomObstacleMin)), highestValue: Int(round(bottomObstacleMax)))
        let randomValue = randomDistribution.nextInt()
        
        bottomObstacle.position = CGPoint(x: startX, y: CGFloat(randomValue))
        worldNode.addChild(bottomObstacle)
        
        
        //Top Obstacle
        let topObstacle = createObstacle()
        topObstacle.zRotation = CGFloat(180).degreesToRadians()
        topObstacle.position = CGPoint(x: startX, y: bottomObstacle.position.y + bottomObstacle.size.height/2 + topObstacle.size.height/2 + player.spriteComponent.node.size.height * gapMultiplier)
        worldNode.addChild(topObstacle)
        
        //Move the obstacles
        let moveX = size.width + topObstacle.size.width
        let moveDuration = moveX / groundSpeed
        
        let sequence = SKAction.sequence([SKAction.moveBy(x: -moveX, y: 0, duration: TimeInterval(moveDuration)), SKAction.removeFromParent()])
        
        topObstacle.run(sequence)
        bottomObstacle.run(sequence)
    }
    
    
    //MARK: - Game Play
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        player.movementComponent.applyImpulse()
        
        if gameState.currentState is PlayingState {
            player.movementComponent.applyImpulse()
        } else if gameState.currentState is GameOverState {
            restartGame()
        }
    }
    
    func restartGame() {
        run(popAction)
        
        let newScene = GameScene(size: size)
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.02)
        view?.presentScene(newScene, transition: transition)
    }
    
    // Physics Contact Delegate Protocol
    
    func didBegin(_ contact: SKPhysicsContact) {
        let other = contact.bodyA.categoryBitMask == PhysicsCategory.Player ? contact.bodyB : contact.bodyA
        
        if other.categoryBitMask == PhysicsCategory.Ground {
            print("Hit Ground")
            gameState.enter(GameOverState.self)
        }
        if other.categoryBitMask == PhysicsCategory.Obstacle {
            print("Hit Obstacle")
            gameState.enter(FallingState.self)
        }
    }
    
 
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if lastUpdateTimeInterval == 0 {
            lastUpdateTimeInterval = currentTime
        }
        
        deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        //Begin Updates
//        updateForeground()
        gameState.update(deltaTime: deltaTime)
        
        //Pre-Entity Updates
        player.update(deltaTime: deltaTime)
    }
    
    func updateForeground() {
        worldNode.enumerateChildNodes(withName: "foreground") { (node, stop) in
            if let foreground = node as? SKSpriteNode {
               let moveAmount = CGPoint(x: -self.groundSpeed * CGFloat(self.deltaTime), y: 0)
                foreground.position += moveAmount
                
                if foreground.position.x < -foreground.size.width {
                    foreground.position += CGPoint(x: foreground.size.width * CGFloat(self.numberOfForegrounds), y: 0)
                }
            }
        }
    }
}
