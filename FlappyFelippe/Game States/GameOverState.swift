//
//  GameOverState.swift
//  FlappyFelippe
//
//  Created by Imrul Kayes on 2/14/18.
//  Copyright © 2018 Imrul Kayes. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOverState: GKState {
    unowned let scene: GameScene
    let hitGround = SKAction.playSoundFileNamed("hitGround.wav", waitForCompletion: false)
    
    init(scene: SKScene) {
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        scene.run(hitGround)
        scene.stopSpawning()
        
        scene.player.movementAllowed = false
        
        showScorecard()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PlayingState.Type
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
    
    //MARK: Scoring
    func setBestScore(bestScore: Int) {
        UserDefaults.standard.set(bestScore, forKey: "BestScore")
        UserDefaults.standard.synchronize()
    }
    
    func bestScore() -> Int {
        return UserDefaults.standard.integer(forKey: "BestScore")
    }
    
    func showScorecard() {
        if scene.score > bestScore() {
            setBestScore(bestScore: scene.score)
        }
        
        let scoreCard = SKSpriteNode(imageNamed: "ScoreCard")
        scoreCard.position = CGPoint(x: scene.size.width * 0.5, y: scene.size.height * 0.5)
        scoreCard.name = "Tutorial"
        scoreCard.zPosition = Layer.UI.rawValue
        scene.worldNode.addChild(scoreCard)
        
        let lastScore = SKLabelNode(fontNamed: scene.fontName)
        lastScore.fontColor = SKColor(red: 101.0/255.0, green: 71.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        lastScore.position = CGPoint(x: -scoreCard.size.width * 0.25, y: -scoreCard.size.height * 0.2)
        lastScore.zPosition = Layer.UI.rawValue
        lastScore.text = "\(scene.score/2)"
        scoreCard.addChild(lastScore)
        
        let bestScoreLabel = SKLabelNode(fontNamed: scene.fontName)
        bestScoreLabel.fontColor = SKColor(red: 101.0/255.0, green: 71.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        bestScoreLabel.position = CGPoint(x: scoreCard.size.width * 0.25, y: -scoreCard.size.height * 0.2)
        bestScoreLabel.zPosition = Layer.UI.rawValue
        bestScoreLabel.text = "\(bestScore()/2)"
        scoreCard.addChild(bestScoreLabel)
        
        let gameOver = SKSpriteNode(imageNamed: "GameOver")
        gameOver.position = CGPoint(x: scene.size.width/2, y: scene.size.height/2 + scoreCard.size.height/2 + scene.margin + gameOver.size.height/2)
        gameOver.zPosition = Layer.UI.rawValue
        scene.worldNode.addChild(gameOver)
        
        let okButton = SKSpriteNode(imageNamed: "Button")
        okButton.position = CGPoint(x: scene.size.width * 0.25, y: scene.size.height/2 - scoreCard.size.height/2 - scene.margin - okButton.size.height/2)
        okButton.zPosition = Layer.UI.rawValue
        scene.worldNode.addChild(okButton)
        
        let ok = SKSpriteNode(imageNamed: "OK")
        ok.position = CGPoint.zero
        ok.zPosition = Layer.UI.rawValue
        okButton.addChild(ok)
        
        let shareButton = SKSpriteNode(imageNamed: "Button")
        shareButton.position = CGPoint(x: scene.size.width * 0.75, y: scene.size.height/2 - scoreCard.size.height/2 - scene.margin - shareButton.size.height/2)
        shareButton.zPosition = Layer.UI.rawValue
        scene.worldNode.addChild(shareButton)
        
        let share = SKSpriteNode(imageNamed: "Share")
        share.position = CGPoint.zero
        share.zPosition = Layer.UI.rawValue
        shareButton.addChild(share)
    }
}
