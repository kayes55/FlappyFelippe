//
//  TutorialState.swift
//  FlappyFelippe
//
//  Created by Imrul Kayes on 2/15/18.
//  Copyright © 2018 Imrul Kayes. All rights reserved.
//

import SpriteKit
import GameplayKit

class TutorialState: GKState {
    unowned let scene: GameScene
    
    init(scene: SKScene) {
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        
    }
    
    override func willExit(to nextState: GKState) {
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PlayingState.Type
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
}
