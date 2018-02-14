//
//  PlayerEntity.swift
//  FlappyFelippe
//
//  Created by Imrul Kayes on 2/13/18.
//  Copyright © 2018 Imrul Kayes. All rights reserved.
//

import SpriteKit
import GameplayKit

class Player: GKEntity {
    
    var spriteComponent: SpriteComponent!
    var movementComponent: MovementComponent!
    
    var animationComponent: AnimationComponent!
    var numberOfFrames = 3
    
    //temporary flag; will be replaced with player state machine later
    var movementAllowed: Bool = false
    
    init(imageName: String) {
        super.init()
        
        let texture = SKTexture(imageNamed: imageName)
        spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        addComponent(spriteComponent)
        
        movementComponent = MovementComponent(entity: self)
        addComponent(movementComponent)
        
        //MARK: applying initial Impulse
        movementComponent.applyInitialImpulse()
        
        //create textures and add to player
        var textures: Array<SKTexture> = []
        for i in 0..<numberOfFrames {
            textures.append(SKTexture(imageNamed: "Bird\(i)"))
        }
        
        for i in stride(from: numberOfFrames, to: 0, by: -1) {
            textures.append(SKTexture(imageNamed: "Bird\(i)"))
        }
        
        animationComponent = AnimationComponent(entity: self, textures: textures)
        addComponent(animationComponent)
        
        // Add Physics
        //MARK:- Physics done by this site: http://insyncapp.net/SKPhysicsBodyPathGenerator.html
        
        let spriteNode = spriteComponent.node
        
        let offsetX: CGFloat = spriteNode.frame.size.width * spriteNode.anchorPoint.x
        let offsetY: CGFloat = spriteNode.frame.size.height * spriteNode.anchorPoint.y
        let path: CGMutablePath = CGMutablePath()
        path.move(to: CGPoint(x: 20 - offsetX, y: 28 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 16 - offsetX, y: 25 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 13 - offsetX, y: 22 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 8 - offsetX, y: 22 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 2 - offsetX, y: 21 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 0 - offsetX, y: 17 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 0 - offsetX, y: 12 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 1 - offsetX, y: 7 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 3 - offsetX, y: 3 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 6 - offsetX, y: 1 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 9 - offsetX, y: 0 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 24 - offsetX, y: 1 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 33 - offsetX, y: 3 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 37 - offsetX, y: 5 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 39 - offsetX, y: 10 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 39 - offsetX, y: 25 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 35 - offsetX, y: 29 - offsetY), transform: .identity)
        path.closeSubpath()
        spriteNode.physicsBody = SKPhysicsBody(polygonFrom: path)
        spriteNode.physicsBody?.categoryBitMask = PhysicsCategory.Player
        spriteNode.physicsBody?.collisionBitMask = 0
        spriteNode.physicsBody?.contactTestBitMask = PhysicsCategory.Obstacle | PhysicsCategory.Ground
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
