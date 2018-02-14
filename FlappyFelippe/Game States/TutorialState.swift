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
        setUpTutorial()
    }
    
    override func willExit(to nextState: GKState) {
        //Remove Tutorial
        scene.worldNode.enumerateChildNodes(withName: "Tutorial") { (node, stop) in
            node.run(SKAction.sequence([
            SKAction.fadeOut(withDuration: 0.5),
            SKAction.removeFromParent()
            ]))
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PlayingState.Type
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
    
    func setUpTutorial() {
        scene.setUpBackground()
        scene.setUpForeground()
        scene.setUpPlayer()
        scene.setUpScoreLabel()
        
        let tutorial = SKSpriteNode(imageNamed: "Tutorial")
        tutorial.position = CGPoint(x: scene.size.width * 0.5, y: scene.playableHeight * 0.4 + scene.playableStart)
        tutorial.name = "Tutorial"
        tutorial.zPosition = Layer.UI.rawValue
        scene.worldNode.addChild(tutorial)
        
        let ready = SKSpriteNode(imageNamed: "Ready")
        ready.position = CGPoint(x: scene.size.width * 0.5, y: scene.playableHeight * 0.7 + scene.playableStart)
        ready.name = "Tutorial"
        ready.zPosition = Layer.UI.rawValue
        scene.worldNode.addChild(ready)
    }
}
