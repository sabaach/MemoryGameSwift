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
    var otherNode1: SKSpriteNode!
    var otherNode2: SKSpriteNode!
    var otherNode3: SKSpriteNode!
    var tappableNode: SKSpriteNode!
    var tappableNode1: SKSpriteNode!
    var tappableNode2: SKSpriteNode!
    var tappableNode3: SKSpriteNode!
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
        
        //#OtherNode
        if let node = self.childNode(withName: "boxkoran") as? SKSpriteNode {
            otherNode = node
        } else {
            print("otherNode not found!")
        }
        
        if let onode = self.childNode(withName: "boxbottle") as? SKSpriteNode {
            otherNode1 = onode
        } else {
            print("otherNode not found!")
        }
        
        if let onode1 = self.childNode(withName: "boxkaleng") as? SKSpriteNode {
            otherNode2 = onode1
        } else {
            print("otherNode not found!")
        }
        
        if let onode2 = self.childNode(withName: "boxpesawat") as? SKSpriteNode {
            otherNode3 = onode2
        } else {
            print("otherNode not found!")
        }
        
        //#TappableNode
        
        // Set up tappableNode
        if let node1 = self.childNode(withName: "koran") as? SKSpriteNode {
            tappableNode = node1
        } else {
            print("tappableNode not found!")
        }
        
        if let node2 = self.childNode(withName: "pesawat") as? SKSpriteNode {
            tappableNode1 = node2
        } else {
            print("tappableNode not found!")
        }
        
        if let node3 = self.childNode(withName: "kalengputih") as? SKSpriteNode {
            tappableNode2 = node3
        } else {
            print("tappableNode not found!")
        }
        
        if let node4 = self.childNode(withName: "bottle") as? SKSpriteNode {
            tappableNode3 = node4
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
                if touchedNode == tappableNode {
                    count += 1
                    print("Benar")
                    if count >= 4 {
                        moveToSecondScene()
                    } else {
                        //tidak muncul di layar???
                        changeOtherNodeColor()
                        // Setelah dipencet 1x remove tappablenode dari parent sehingga tappablenode tidak bisa di spam
//                        tappableNode.removeFromParent()
                        
                    }
                    tappableNode.removeFromParent()
                }
                else if touchedNode == tappableNode1 {
                    count += 1
                    print("Benar")
                    if count >= 4 {
                        moveToSecondScene()
                    } else {
                        //tidak muncul di layar???
                        otherNode3.color = .green
                        // Setelah dipencet 1x remove tappablenode dari parent sehingga tappablenode tidak bisa di spam
//                        tappableNode.removeFromParent()
                        
                    }
                    tappableNode1.removeFromParent()
                }
                else if touchedNode == tappableNode2 {
                    count += 1
                    print("Benar")
                    if count >= 4 {
                        moveToSecondScene()
                    } else {
                        //tidak muncul di layar???
                        otherNode2.color = .green
                        // Setelah dipencet 1x remove tappablenode dari parent sehingga tappablenode tidak bisa di spam
//                        tappableNode.removeFromParent()
                        
                    }
                    tappableNode2.removeFromParent()
                }
                else if touchedNode == tappableNode3 {
                    count += 1
                    print("Benar")
                    if count >= 4 {
                        moveToSecondScene()
                    } else {
                        //tidak muncul di layar???
                        otherNode1.color = .green
                        // Setelah dipencet 1x remove tappablenode dari parent sehingga tappablenode tidak bisa di spam
//                        tappableNode.removeFromParent()
                        
                    }
                    tappableNode3.removeFromParent()
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

