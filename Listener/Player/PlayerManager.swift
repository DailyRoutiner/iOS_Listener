//
// PlayerManager.swift
// Listener
// Sennen Agukwe 
//

import AVFoundation
import UIKit

class PlayerManager: NSObject {
    var player: AVAudioPlayer!
    
    // MARK: - Constructor
    override init() {
        super.init()
        
        // Get audio file path
        let audioPath = URL(fileURLWithPath: Bundle.main.path(forResource: "theadventureofthebluecarbuncle_01", ofType: "mp3")!)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            // Prepare player
            self.player = try AVAudioPlayer(contentsOf: audioPath)
        } catch _ {
            fatalError("Initialization error.")
        }

        player.delegate = self
        player.enableRate = true    // Enable playing rate change
        player.prepareToPlay()
    }

    // MARK: - Internal methods

    func playOrPause() {
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }

    func setRate(_ rate: Float) {
        player.rate = rate
    }
    
    func setPlayingTime(_ pos: Double) {
        player.currentTime = pos
    }
}

extension PlayerManager: AVAudioPlayerDelegate {

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()

        // Send notification
        let notification = Notification(name: Notification.Name(rawValue: "stop"), object: self)
        NotificationCenter.default.post(notification)
    }

}
