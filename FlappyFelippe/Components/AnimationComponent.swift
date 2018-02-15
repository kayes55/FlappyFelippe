//
//  AnimationComponent.swift
//  FlappyFelippe
//
//  Created by Imrul Kayes on 2/15/18.
//  Copyright © 2018 Imrul Kayes. All rights reserved.
//

import SpriteKit
import GameplayKit

class AnimationComponent: GKComponent {
    
    let spriteComponent: SpriteComponent
    var textures: Array<SKTexture> = []
    
    init(entity: GKEntity, textures: Array<SKTexture>) {
        self.textures = textures
        self.spriteComponent = entity.component(ofType: SpriteComponent.self)!
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if let player = entity as? Player {
            if player.movementAllowed {
                startAnimation()
            } else {
                stopAnimation(name: "Flap")
            }
        }
    }
    
    
    func startWobble() {
        let moveUp = SKAction.moveBy(x: 0, y: 10, duration: 0.4)
        moveUp.timingMode = .easeInEaseOut
        let moveDown = moveUp.reversed()
        let sequence = SKAction.sequence([moveUp, moveDown])
        let repeatWobble = SKAction.repeatForever(sequence)
        spriteComponent.node.run(repeatWobble, withKey: "Wobble")
        
        let flapWings = SKAction.animate(with: textures, timePerFrame: 0.07)
        let repeatFlap = SKAction.repeatForever(flapWings)
        spriteComponent.node.run(repeatFlap, withKey: "Wobble-flap")
    }
    
    func stopWobble() {
        stopAnimation(name: "Wobble")
        stopAnimation(name: "Wobble-flap")
    }
    
    //Modifying StartAnimation & stopAnimation methods
    func startAnimation() {
        if (spriteComponent.node.action(forKey: "Flap") == nil) {
            let playerAnimation = SKAction.animate(with: textures, timePerFrame: 0.07)
            let repeatAction = SKAction.repeatForever(playerAnimation)
            spriteComponent.node.run(repeatAction, withKey: "Flap")
        }
    }
    
    func stopAnimation(name: String) {
        spriteComponent.node.removeAction(forKey: name)
    }
}
