//
//  GameViewController.swift
//  NanoChallenge 1
//
//  Created by Ferris Leroy Winata on 24/04/24.
//

import UIKit
import SpriteKit
//import GameplayKit

protocol gameViewDelegate {
//    func gameIsFinished()
}

class GameViewController: UIViewController {
    var delegate: gameViewDelegate?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let newView = SKView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        self.view = newView
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameOpeningScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
//                scene.referenceOfGameViewController = self
                // Present the scene
                view.presentScene(scene)
            }
            else {
                print("Error: GameOpeningScene.sks file not found")
            }
        }
        
        else {
                print("Error: Failed to create SKView")
            }
        }
    }

//let nextScene = SecondScene(size: self.size)
//self.view?.presentScene(nextScene)
