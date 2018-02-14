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
    
    //Adding some properties for Angular animation
    var velocityModifier: CGFloat = 1000.0
    var angularVelocity: CGFloat = 0.0
    let minDegrees: CGFloat = -90
    let maxDegrees: CGFloat = 25
    
    //screen touch time detection
    var lastTouchTime: TimeInterval = 0
    var lastTouchY: CGFloat = 0.0
    
    init(entity: GKEntity) {
        self.spriteComponent = entity.component(ofType: SpriteComponent.self)
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyInitialImpulse() {
        velocity = CGPoint(x: 0, y: impulse * 2)
    }
    
    //MARK: Modifying applyImpulse
    func applyImpulse(lastUpdateTime: TimeInterval) {
        velocity = CGPoint(x: 0.0, y: impulse)
        
        angularVelocity = velocityModifier.degreesToRadians()
        lastTouchTime = lastUpdateTime
        lastTouchY = spriteComponent.node.position.y
    }
    
    func applyMovement (_ seconds: TimeInterval) {
        let spriteNode = spriteComponent.node
        
        //Apply Gravity
        let gravityStep = CGPoint(x: 0, y: gravity) * CGFloat(seconds)
        velocity += gravityStep
        
        //Apply velocity
        let velocityStep = velocity * CGFloat(seconds)
        spriteNode.position += velocityStep
        
        //After Modifying applyImpulse, we have to implement this code
        if spriteNode.position.y < lastTouchY {
            angularVelocity = -velocityModifier.degreesToRadians()
        }
        
        //Rotate Felipe
        let angularStep = angularVelocity * CGFloat(seconds)
        spriteNode.zRotation += angularStep
        spriteNode.zRotation = min(max(spriteNode.zRotation, minDegrees.degreesToRadians()), maxDegrees.degreesToRadians())
        
        //Temporary ground hit
        if spriteNode.position.y - spriteNode.size.height/2 < playableStart {
            spriteNode.position = CGPoint(x: spriteNode.position.x, y: playableStart + spriteNode.size.height/2)
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if let player = entity as? Player {
            if player.movementAllowed {
                applyMovement(seconds)
            }
        }
    }
}
