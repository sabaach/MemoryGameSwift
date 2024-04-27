import UIKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Lakukan setup untuk tampilan splash screen jika diperlukan
        // Misalnya, atur gambar latar belakang atau tindakan lainnya.
        // Untuk contoh sederhana, Anda bisa menggunakan UIImage sebagai latar belakang.
        let splashImageView = UIImageView(image: UIImage(named: "AppIcon"))
        splashImageView.frame = view.bounds
        splashImageView.contentMode = .scaleAspectFill
        view.addSubview(splashImageView)
        
        // Set timer untuk menampilkan splash screen selama beberapa detik sebelum pindah ke GameViewController
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
