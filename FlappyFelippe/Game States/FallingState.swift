//
//  FallingState.swift
//  FlappyFelippe
//
//  Created by Imrul Kayes on 2/14/18.
//  Copyright © 2018 Imrul Kayes. All rights reserved.
//

import SpriteKit
import GameplayKit

class FallingState: GKState {
    unowned let scene: GameScene
    
    //store sounds
    let whackAction = SKAction.playSoundFileNamed("whack.wav", waitForCompletion: false)
    let fallingAction = SKAction.playSoundFileNamed("falling.wav", waitForCompletion: false)
    
    init(scene: SKScene) {
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        scene.run(SKAction.sequence([whackAction, SKAction.wait(forDuration: 0.1), fallingAction]))
        scene.stopSpawning()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameOverState.Type
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
}
