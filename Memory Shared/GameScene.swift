//
//  GameScene.swift
//  Memory Shared
//
//  Created by Syafrie Bachtiar on 23/04/24.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    
    var count = 0
    var otherNode: SKSpriteNode!
//    var backgroundMusic: SKAudioNode!

    
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    
    func setUpScene() {
        BackgroundMusic.shared.playBackgroundMusic()
        // Get otherNode from GameScene.sks
        if let node = self.childNode(withName: "boxkoran") as? SKSpriteNode {
            otherNode = node
        } else {
            print("otherNode not found!")
        }

        // Set up tappableNode
        if let tappableNode = self.childNode(withName: "koran") as? SKSpriteNode {
            tappableNode.name = "tappableNode"
        } else {
            print("tappableNode not found!")
        }
        
//        if let musicURL = Bundle.main.url(forResource: "background_music", withExtension: "mp3") {
//            backgroundMusic = SKAudioNode(url: musicURL)
//            addChild(backgroundMusic)
//        }
        
    }
    
    func changeOtherNodeColor() {
            otherNode.color = .green
        }

    func moveToSecondScene() {
            let nextScene = SecondScene(size: self.size)
            self.view?.presentScene(nextScene)
        }

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in touches {
                let location = touch.location(in: self)
                let touchedNode = self.atPoint(location)
                //kasih operator atau untuk tappablenode yang lain kemudian hapus parentnya
                if touchedNode.name == "tappableNode" {
                    count += 1
                    if count >= 3 {
                        moveToSecondScene()
                    } else {
                        //tidak muncul di layar???
                        changeOtherNodeColor()
                        // Setelah dipencet 1x remove tappablenode dari parent sehingga tappablenode tidak bisa di spam
//                        tappableNode.removeFromParent()
                    }
                }
            }
        }
    
    deinit {
            BackgroundMusic.shared.stopBackgroundMusic()
        }
    
    }

    
    


#if os(OSX)
// Mouse-based event handling
extension GameScene {

    override func mouseDown(with event: NSEvent) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        self.makeSpinny(at: event.location(in: self), color: SKColor.green)
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.makeSpinny(at: event.location(in: self), color: SKColor.blue)
    }
    
    override func mouseUp(with event: NSEvent) {
        self.makeSpinny(at: event.location(in: self), color: SKColor.red)
    }

}
#endif

