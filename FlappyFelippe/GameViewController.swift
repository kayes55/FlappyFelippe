//
//  GameViewController.swift
//  FlappyFelippe
//
//  Created by Imrul Kayes on 2/12/18.
//  Copyright © 2018 Imrul Kayes. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


var aspectRatio: CGFloat = 0.0
class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let skView = self.view as? SKView {
            if skView.scene == nil {
                // Create the secene
                aspectRatio = skView.bounds.size.height / skView.bounds.size.width
                let scene = GameScene(size: CGSize(width: 320.0, height: 320.0 * aspectRatio), stateClass: MainMenuState.self)

                skView.showsFPS = true
                skView.showsNodeCount = true
                skView.showsPhysics = true
                skView.ignoresSiblingOrder = true

                scene.scaleMode = .aspectFill

                skView.presentScene(scene)
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
