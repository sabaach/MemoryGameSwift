//
//  GameScene.swift
//  NanoChallenge 1
//
//  Created by Ferris Leroy Winata on 24/04/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var characterTypes: [SKTexture] = []
    private var points : SKLabelNode?
    private var character : SKSpriteNode?
    
    let bombCategory:UInt32 = 0x1
    let pointCategory:UInt32 = 0x10
    let characterCategory:UInt32 = 0x100
    let groundCategory:UInt32 = 0x1000
   
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.points = self.childNode(withName: "//points") as? SKLabelNode
    
        //Character
        self.character = self.childNode(withName: "//character") as? SKSpriteNode
        
        
        //Types ini akan dipakai untuk menyimpan bentuk character buat character di gamenya.
        //Hanya bisa digunakkan di file "GameScene" karena menggunakan Acces Modifier "PRIVATE"
        
//        characterTypes.append(SKTexture(imageNamed: "Character"))
//        characterTypes.append(SKTexture(imageNamed: "Explode"))
//        
//        let animation = SKAction.animate(with: characterTypes, timePerFrame: 0.2)
//        let animationRepeat = SKAction.repeatForever(animation)
//        character!.run(animationRepeat)
        
        character?.physicsBody?.categoryBitMask = characterCategory
        character?.physicsBody?.contactTestBitMask = pointCategory | bombCategory
        
        // Action ketika character bertabrakan antara 2 ini
        character?.physicsBody?.collisionBitMask = pointCategory | bombCategory
        
        let ground = self.childNode(withName: "\\ground") as?SKSpriteNode
        ground?.physicsBody?.categoryBitMask = groundCategory
        ground?.physicsBody?.contactTestBitMask = pointCategory | bombCategory
        ground?.physicsBody?.collisionBitMask = pointCategory | bombCategory
        
        //Atur Kekuatan Gravitasi pada Game
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.8)

    }
    
    func fallingObject(){
        
        //Random apa yang jatuh (Antara point dan juga bomb)
        // 1 = Bomb , 2 = point
        let random = Int.random(in: 1...2) //Ini akan membuat random menjatuhkan antara bomb / point
        let randomPosition1 = Int.random(in: -370...370) //Posisi pada GameScenenya (Sumbu X)
        let randomPosition  = Int.random(in: 660...700) //Posisi pada GameScenenya (Sumbu y)
        
    }
    
    //Memulai kerangka buat touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     
    }
 
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered (Akan dipakai)
      
        
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
