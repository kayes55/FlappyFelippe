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
class GameViewController: UIViewController, GameSceneDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let skView = self.view as? SKView {
            if skView.scene == nil {
                // Create the secene
                aspectRatio = skView.bounds.size.height / skView.bounds.size.width
                // this scene is only supported iPhone 6, codes should be refactored for all screen sizes
                let scene = GameScene(size: CGSize(width: 320.0, height: 320.0 * aspectRatio), stateClass: MainMenuState.self, delegate: self)

                skView.showsFPS = false
                skView.showsNodeCount = false
                skView.showsPhysics = false
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
    
    func screenShot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 1.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func shareString(string: String, url: URL, image: UIImage) {
        let vc = UIActivityViewController(activityItems: [string, url, image], applicationActivities: nil)
        present(vc, animated: true, completion: nil)
    }
}
