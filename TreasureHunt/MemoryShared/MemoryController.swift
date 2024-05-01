//
//  MemoryController.swift
//  TreasureHunt
//
//  Created by Syafrie Bachtiar on 30/04/24.
//

import UIKit
import SpriteKit

protocol MemoryDelegate {
    func gameIsFinish()
}

class MemoryController: UIViewController {
    
    @IBAction func dismissScene(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var delegate: MemoryDelegate?
    
    override func viewDidLoad() {
        //Untuk force landscape
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        super.viewDidLoad()
        
//        delegate?.gameIsFinish()
        let newView = SKView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        self.view = newView
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene1") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
//                scene.referenceOfGameViewController = self
                // Present the scene
                view.presentScene(scene)
            }
        }
        
    }
    
}
