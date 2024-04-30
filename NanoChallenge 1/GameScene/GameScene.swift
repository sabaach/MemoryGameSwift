//
//  GameScene.swift
//  NanoChallenge 1
//
//  Created by Ferris Leroy Winata on 24/04/24.
//

import SpriteKit
import GameplayKit
import CoreMotion
import AVFoundation

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
    
    //cmManager
    let coreMotionManager = CMMotionManager()
    
    //BackgroundMusic
    var backgroundMusicPlayer: AVAudioPlayer!
    var destX: CGFloat = 0.0
    
    var accelerometer = true

   
    
    override func didMove(to view: SKView) {

        self.physicsWorld.contactDelegate = self
        
        coreMotionManager.startAccelerometerUpdates()
        
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
        
        
        // Song
        

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
        
        //KALAU BERGERAK DENGAN TAP LAYAR
        
        
//        let touch = touches.first
//        if let location = touch?.location(in: self){
//
//            if location.x > (character?.position.x)! / 2 {
//                character?.position.x += 30 //Berjalan sejauh skala 30 ke kanan
//            }
//            else if location.x < (character?.position.x)! / 2 {
//                character?.position.x -= 30 //Berlajan sejauh skala 30 ke kiri
//            }
          
        // Gyro
          
//        }

     
    }
    
    //Movement dari character game ke kiri dan kanan
    func moveX() {
        if accelerometer == true && coreMotionManager.isAccelerometerAvailable {
            coreMotionManager.accelerometerUpdateInterval = 0.1
            coreMotionManager.startAccelerometerUpdates(to: .main) {
                (data, error) in
                guard let data = data, error == nil else {
                    return
                }

                let currentX = self.character?.position.x
                self.destX = currentX! + CGFloat(data.acceleration.x * 1000)
            }
        }
    }
    
    //Limit pergerakkan character supaya mentok di scene saja
    func sideConstraints() {
        let rightConstraint = size.width/2 - 70
        let leftConstraint = rightConstraint*(-1)
        let positionX = character?.position.x
        
        if (positionX! > rightConstraint) {
            character?.run(SKAction.moveTo(x: rightConstraint, duration: 0.1))
            if destX < rightConstraint {
                character?.run(SKAction.moveTo(x: destX, duration: 1))
            }
        }
        
        if (positionX! < leftConstraint) {
            character?.run(SKAction.moveTo(x: leftConstraint, duration: 0.1))
            if destX > leftConstraint {
                character?.run(SKAction.moveTo(x: destX, duration: 1))
            }
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
                limitAmount -= 1
            }
            else {
                contact.bodyB.node?.removeFromParent()
                limitAmount -= 1
            }
           
            if (pointsCollected == 5) {
                let scene = GameOverScene(fileNamed: "GameWinScene")
                scene!.scaleMode = .fill
                let ending = SKTransition.push(with: .down, duration: 1.7)
                self.view?.presentScene(scene!, transition: ending )
                
                //Stop Music
                AudioManager.shared.stopBackgroundMusic()
            }
            
            
        }
        
        else if collide == characterCategory | bombCategory {
            
            character?.texture = SKTexture(imageNamed: "Explode")
            
            //Call Scene
            let scene = GameOverScene(fileNamed: "GameOverScene")
            scene!.scaleMode = .fill
            let ending = SKTransition.push(with: .down, duration: 1.7)
            self.view?.presentScene(scene!, transition: ending )
        }
        

    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered (Akan dipakai)
        
        //Kalau amount yang jatuh totalnya dibawah 5 dia akan menjalankan function falling Object, tetapi kalau sudah, dia akan stop
        if(limitAmount < 5){
            fallingObject()
        }
        
        moveX()
        character?.run(SKAction.moveTo(x: destX, duration: 1))
        sideConstraints()
        
    }
    
    

}
