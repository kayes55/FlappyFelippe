//
//  ObstacleEntity.swift
//  FlappyFelippe
//
//  Created by Imrul Kayes on 2/13/18.
//  Copyright © 2018 Imrul Kayes. All rights reserved.
//

import SpriteKit
import GameplayKit

class Obstacle: GKEntity {
    var spriteComponent: SpriteComponent!
    
    init(imageName: String) {
        super.init()
        
        let texture = SKTexture(imageNamed: imageName)
        spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        addComponent(spriteComponent)
        
        // Add Physics
        let spriteNode = spriteComponent.node
        
        spriteNode.physicsBody = SKPhysicsBody(rectangleOf: spriteNode.size)
        spriteNode.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
        spriteNode.physicsBody?.collisionBitMask = 0
        spriteNode.physicsBody?.contactTestBitMask = PhysicsCategory.Player
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
