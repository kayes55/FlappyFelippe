//
//  SpriteComponent.swift
//  FlappyFelippe
//
//  Created by Imrul Kayes on 2/13/18.
//  Copyright © 2018 Imrul Kayes. All rights reserved.
//

import SpriteKit
import GameplayKit


class SpriteComponent: GKComponent {
    let node: SKSpriteNode
    
    init(entity: GKEntity, texture: SKTexture, size: CGSize) {
        node = SKSpriteNode(texture: texture, color: SKColor.white, size: size)
        node.entity = entity
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
