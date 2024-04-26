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
        
        
        // Get label node from scene and store it for use later
        let status = self.childNode(withName: "//status") as? SKSpriteNode
        
        let label = self.childNode(withName: "//label") as? SKLabelNode
        
        let retryNode = self.childNode(withName: "//retry") as! SKSpriteNode
        
        if win == false{
//            status?.removeAllChildren()
//            
//            //Image kalau kalah
//            let lossImage = SKSpriteNode(imageNamed: "Failed")
//                
//            //Position
//            lossImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
//                
            //Add image to status node
            self.addChild(lossImage)
            
            
            label?.text = "Better Luck Next Time"
        }
        

    }
    
    //Balik ke scene awal jika ingin main lagi
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = GameScene(fileNamed: "GameScene")
        let transition = SKTransition.crossFade(withDuration: 3)
        scene!.scaleMode = .aspectFit
        self.view?.presentScene(scene)
    }
 
    

    //PINDAH KE SCENE LAIN KETIKA GAME MAU BERUBAH SCENE (MISAL CONGRATULATIONS, GAME OVER)

//        func endGame() {
//            let transition = SKTransition.flipHorizontal(withDuration: 1.0)
//            let gameOver = SKScene(fileNamed: "GameOverScene") as! GameOverScene
//
//            gameOver.scaleMode = .aspectFill
//            gameOver.score = points
//            view!.presentScene(gameOver, transition: transition)
//        }
    
}

