import Foundation
import SpriteKit

class SecondScene: SKScene {
    
    // Mendeklarasikan tombol
    var exitButton: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        // Menambahkan background image
        addBackground()
        
        // Membuat tombol
        createExitButton()
    }
    
    // Fungsi untuk menambahkan background image
    func addBackground() {
        // Menggunakan gambar untuk background
        let backgroundImage = SKSpriteNode(imageNamed: "backgroundBadge") // Ganti "backgroundImage" dengan nama gambar latar belakang yang sesuai
        backgroundImage.position = CGPoint(x: size.width / 2, y: size.height / 2) // Memposisikan background di tengah layar
        backgroundImage.size = CGSize(width: size.width, height: size.height) // Menyesuaikan ukuran background dengan ukuran layar
        backgroundImage.zPosition = -1 // Menempatkan background di layer terdepan
        
        addChild(backgroundImage) // Menambahkan background ke dalam scene
    }
    
    // Fungsi untuk membuat tombol keluar
    func createExitButton() {
        // Menggunakan gambar untuk tombol
        exitButton = SKSpriteNode(imageNamed: "badge3") // Ganti "badge3" dengan nama gambar tombol yang sesuai
        exitButton.position = CGPoint(x: size.width / 2, y: size.height / 2) // Atur posisi tombol di tengah layar
        exitButton.size = CGSize(width: 100, height: 100) // Atur ukuran tombol
        exitButton.name = "exitButton" // Beri nama untuk tombol
        
        addChild(exitButton) // Menambahkan tombol ke dalam scene
    }
    
    // Fungsi untuk menangani ketika tombol ditekan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*for touch in touches {
            let location = touch.location(in: self)
            
            // Memeriksa apakah tombol ditekan
            if exitButton.contains(location) {
                // Keluar dari scene
                exitScene()
            }
        }*/
        if let presentingViewController = view?.window?.rootViewController {
            presentingViewController.dismiss(animated: true, completion: nil)
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
