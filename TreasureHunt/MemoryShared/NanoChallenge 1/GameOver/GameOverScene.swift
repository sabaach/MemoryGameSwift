//
//  GameOver.swift
//  NanoChallenge 1
//
//  Created by Ferris Leroy Winata on 25/04/24.
//


import SpriteKit
import GameplayKit

class GameOverScene: SKScene {
    
    public var win = true
        
    override func didMove(to view: SKView) {
        
        let retryButton = self.childNode(withName: "//retry") as? SKSpriteNode
        let failedStatus = self.childNode(withName: "//failed") as? SKSpriteNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           for touch in touches {
               let location = touch.location(in: self)
               let node = atPoint(location)
               
               // Check if the retry button was touched
               if node.name == "retry" {
                   let scene = GameScene(fileNamed: "GameScene")
                   scene!.scaleMode = .fill
                   self.view?.presentScene(scene)
               }
           }
       }
}

