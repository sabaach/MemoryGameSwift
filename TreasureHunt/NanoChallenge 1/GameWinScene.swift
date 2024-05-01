//
//  Game-Win.swift
//  NanoChallenge 1
//
//  Created by Ferris Leroy Winata on 29/04/24.
//

import SpriteKit
import GameplayKit

class GameWinScene: SKScene {
    
    override func didMove(to view: SKView) {
    
        let victory = self.childNode(withName: "//victory") as? SKSpriteNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Percobaan dulu, ketika tekan screen ganti scene
        let changeScreen = GameScene(fileNamed: "GameScene")
        changeScreen!.scaleMode = .fill
        let ending = SKTransition.fade(with: .black, duration: 1.5)
        self.view?.presentScene(changeScreen! , transition: ending)
       }
}


