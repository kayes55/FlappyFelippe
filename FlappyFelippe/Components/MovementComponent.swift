//
//  MovementComponent.swift
//  FlappyFelippe
//
//  Created by Imrul Kayes on 2/13/18.
//  Copyright © 2018 Imrul Kayes. All rights reserved.
//

import SpriteKit
import GameplayKit

class MovementComponent: GKComponent {
    let spriteComponent: SpriteComponent!
    var velocity = CGPoint.zero
    let gravity:CGFloat = -1500
    var playableStart:CGFloat = 0.0
    let impulse:CGFloat = 400.0
    
    init(entity: GKEntity) {
        self.spriteComponent = entity.component(ofType: SpriteComponent.self)
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyImpulse() {
        velocity = CGPoint(x: 0.0, y: impulse)
    }
    
    func applyMovement (_ seconds: TimeInterval) {
        let spriteNode = spriteComponent.node
        
        //Apply Gravity
        let gravityStep = CGPoint(x: 0, y: gravity) * CGFloat(seconds)
        velocity += gravityStep
        
        //Apply velocity
        let velocityStep = velocity * CGFloat(seconds)
        spriteNode.position += velocityStep
        
        //Temporary ground hit
        if spriteNode.position.y - spriteNode.size.height/2 < playableStart {
            spriteNode.position = CGPoint(x: spriteNode.position.x, y: playableStart + spriteNode.size.height/2)
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        applyMovement(seconds)
    }
}
