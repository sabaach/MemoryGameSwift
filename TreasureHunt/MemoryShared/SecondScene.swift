import Foundation
import SpriteKit

class SecondScene: SKScene {
    // Mendeklarasikan tombol
    var exitButton: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .yellow
        
        // Membuat tombol
        createExitButton()
    }
    
    // Fungsi untuk membuat tombol keluar
    func createExitButton() {
        // Menggunakan gambar untuk tombol
        exitButton = SKSpriteNode(imageNamed: "exitButtonImage") // Ganti "exitButtonImage" dengan nama gambar yang sesuai
        exitButton.position = CGPoint(x: size.width * 0.9, y: size.height * 0.9) // Atur posisi tombol
        exitButton.size = CGSize(width: 50, height: 50) // Atur ukuran tombol
        exitButton.name = "exitButton" // Beri nama untuk tombol
        
        addChild(exitButton) // Menambahkan tombol ke dalam scene
    }
    
    // Fungsi untuk menangani ketika tombol ditekan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            // Memeriksa apakah tombol ditekan
            if exitButton.contains(location) {
                // Keluar dari scene
                exitScene()
            }
        }
    }
    
    // Fungsi untuk keluar dari scene
    func exitScene() {
        // Menggunakan transition untuk kembali ke scene sebelumnya
        if let previousScene = self.view?.scene {
            let transition = SKTransition.fade(withDuration: 0.5)
            previousScene.scaleMode = .aspectFill
            view?.presentScene(previousScene, transition: transition)
        }
    }
}
