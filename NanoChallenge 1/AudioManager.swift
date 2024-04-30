//
//  AudioManager.swift
//  NanoChallenge 1
//
//  Created by Ferris Leroy Winata on 29/04/24.
import AVFoundation

class AudioManager {
    
    static let shared = AudioManager()
    var backgroundMusicPlayer: AVAudioPlayer?

    private init() {}

    func playBackgroundMusic(filename: String) {
        guard let url = Bundle.main.url(forResource: "pixelGameSong", withExtension: "mp3") else {
            print("Could not find the audio file")
            return
        }

        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.prepareToPlay()
            backgroundMusicPlayer?.numberOfLoops = -1 // Loop the music indefinitely
            backgroundMusicPlayer?.play()
        } catch {
            print("Error playing the audio file: \(error.localizedDescription)")
        }
    }

    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }
}
