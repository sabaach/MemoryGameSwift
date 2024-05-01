import UIKit
import AVKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
    }
    
    func playVideo() {
        guard let path = Bundle.main.path(forResource: "one", ofType: "mp4") else {
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
        player.play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoDidFinish), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    @objc func videoDidFinish() {
        // Video selesai diputar, beralih ke tampilan AR
        performSegue(withIdentifier: "toAR", sender: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Override this method if you want to handle orientation changes
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let playerLayer = view.layer.sublayers?.first as? AVPlayerLayer {
            playerLayer.frame = view.bounds
        }
    }
}
