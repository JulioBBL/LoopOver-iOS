//
//  GameViewController.swift
//  Loop Over
//
//  Created by Julio Brazil on 20/12/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    @IBOutlet weak var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneNode.setupGameWith(matrixSize: 5)
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                skView.presentScene(sceneNode)
                
                skView.ignoresSiblingOrder = true
                
                skView.showsFPS = true
                skView.showsNodeCount = true
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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
