//
//  GameScene.swift
//  NanoChallenge 1
//
//  Created by Ferris Leroy Winata on 24/04/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    // SKPhysicsContactDelegate berguna untuk membaca dan menghandle physic contact di scenenya

    private var points : SKLabelNode?
    private var character : SKSpriteNode?
    private var characterShape: [SKTexture] = []
    // Perbedaan value supaya program mendetect adanya tabrakan antar Object
    // Penggunaan operasi bitwise untuk menggabungkan beberapa kategori dan membuat skenario tabrakan yang kompleks.

    let bombCategory:UInt32 = 0x1  //Akan memiliki category bitMask '0x1'
    let pointCategory:UInt32 = 0x10
    let characterCategory:UInt32 = 0x100
    let groundCategory:UInt32 = 0x1000
    
    // Untuk melimit berapa banyak object yang jatuh supaya tidak terlalu banyak
    private var limitAmount : Int = 0
    
    //Untuk menghitung jumlah points yang tercollect
    private var pointsCollected : Int = 0
   
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        // Get label node from scene and store it for use later
        self.points = self.childNode(withName: "//points") as? SKLabelNode
    
        //Character
        self.character = self.childNode(withName: "//character") as? SKSpriteNode

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
        let randomPosition2  = Int.random(in: 660...700) //Posisi pada GameScenenya (Sumbu y)
        
        var points = SKSpriteNode(imageNamed: "StarPixel")
        points.position = CGPoint(x: randomPosition1, y: randomPosition2)
        points.size = CGSize(width: 120, height: 120)
        points.name = "point"
        
        points.physicsBody = SKPhysicsBody.init(circleOfRadius: 30)
        points.physicsBody?.categoryBitMask = pointCategory
        points.physicsBody?.contactTestBitMask = groundCategory | characterCategory
        addChild(points)
        
        if (random == 1){
            points.name = "bomb"
            points.texture = SKTexture(imageNamed: "bomb")
            points.physicsBody?.categoryBitMask = bombCategory
        }
        limitAmount += 1
 
    }
    
    //Memulai kerangka buat touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Disentuh dia akan bergeser ke arah tertentu
        let touch = touches.first
        if let location = touch?.location(in: self){
        
            if location.x > (character?.position.x)! / 2 {
                character?.position.x += 30 //Berjalan sejauh skala 30 ke kanan
            }
            else if location.x < (character?.position.x)! / 2 {
                character?.position.x -= 30 //Berlajan sejauh skala 30 ke kiri
            }
          
        // Gyro
          
        }

     
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
         characterContact(contact)
     }
 
    //Function ketika character mengenai objek
    func characterContact(_ contact: SKPhysicsContact) {
        
        let Body1 = contact.bodyA.node?.name
        let Body2 = contact.bodyB.node?.name
        
        
        if ((Body1 == "point") && (Body2 == "ground")) || ((Body1 == "bomb") && (Body2 == "ground")) {
            //Ketika bomb ataupun point terkena ground, maka akan hilang objectnya, dengan func .removeFromParent()
            contact.bodyA.node?.removeFromParent()
            limitAmount -= 1
        }
        
        else if ((Body1 == "ground") && (Body2 == "bomb")) || ((Body1 == "ground") && (Body2 == "point")) {
            //Ketika bomb ataupun point terkena ground, maka akan hilang objectnya, dengan func .removeFromParent()
            contact.bodyB.node?.removeFromParent()
            limitAmount -= 1
        }
        
        let collide: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collide == characterCategory | pointCategory {
            
            pointsCollected += 1
            points?.text = "\(pointsCollected)"
            
            if(Body1 == "point") {
                contact.bodyA.node?.removeFromParent()
            }
            else {
                contact.bodyB.node?.removeFromParent()
            }
           
            if (pointsCollected == 3) {
                let scene = GameOverScene(fileNamed: "GameWinScene")
                scene!.scaleMode = .fill
                let ending = SKTransition.push(with: .down, duration: 3.0)
                self.view?.presentScene(scene!, transition: ending )
            }
            
            
        }
        
        else if collide == characterCategory | bombCategory {
            
            character?.texture = SKTexture(imageNamed: "Explode")
            
            //Call Scene
            let scene = GameOverScene(fileNamed: "GameOverScene")
            scene!.scaleMode = .fill
            let ending = SKTransition.push(with: .down, duration: 3.0)
            self.view?.presentScene(scene!, transition: ending )
        }
        

    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered (Akan dipakai)
        
        //Kalau amount yang jatuh totalnya dibawah 5 dia akan menjalankan function falling Object, tetapi kalau sudah, dia akan stop
        if(limitAmount <= 3){
            fallingObject()
        }
        
        
    }
    
    

}
