//
//  GameOpeningScene.swift
//  NanoChallenge 1
//
//  Created by Ferris Leroy Winata on 29/04/24.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameOpeningScene: SKScene {
    
    var backgroundMusicPlayer: AVAudioPlayer!


    override func didMove(to view: SKView) {
        
        AudioManager.shared.playBackgroundMusic(filename: "GameOpeningScene")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            // Check if the retry button was touched
            if node.name == "play" {
                let scene = GameScene(fileNamed: "GameScene")
                scene!.scaleMode = .fill
                let ending = SKTransition.fade(with: .white, duration: 1.8)
                self.view?.presentScene(scene!, transition: ending )
                
            }
        }
    }
    
}



