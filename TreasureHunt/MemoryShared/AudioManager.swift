import AVFoundation

class BackgroundMusic {
    static let shared = BackgroundMusic()
    private var backgroundMusicPlayer: AVAudioPlayer?

    func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "Bink's Sake (Instrumental)", withExtension: "mp3") else {
            print("Background music file not found!")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1
            backgroundMusicPlayer?.volume = 0.5
            backgroundMusicPlayer?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }

    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }
}
