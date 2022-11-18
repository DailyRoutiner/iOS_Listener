//
//  PlayerViewController.swift
//  Listener
//  Sennen Agukwe 
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var playTimeSlider: UISlider!
    @IBOutlet weak var playTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var controlButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    private let manager = PlayerManager()
    
    private var playingTimeTimer : Timer?
    private var book: Book? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(self.audioDidStopped), name: NSNotification.Name(rawValue: "stop"), object: nil)

        // Set audio length
        self.playTimeSlider.maximumValue = Float(self.manager.player.duration)
        self.totalTimeLabel.text = self.formatTimeString(self.manager.player.duration)
        
        if let str = book?.image {
            bookImageView.image = UIImage(named: str)
        }
        titleLabel.text = book?.name
        
        self.controlButtonAction(self.controlButton)
    }
    
    func setBook(book: Book) {
        self.book = book
    }
    
    @IBAction func playTimeSliderDidChanged(_ sender: Any) {
        self.manager.setPlayingTime(Double(self.playTimeSlider.value))
        self.updatePlayingTime()
        self.title = "Player"
    }
    
    @IBAction func controlButtonAction(_ sender: Any) {
        self.manager.playOrPause()

        if self.manager.player.isPlaying {
            self.controlButton.setImage(UIImage(named: "pause"), for: .normal)
            // Start timer
            if self.playingTimeTimer == nil {
                self.playingTimeTimer = Timer.scheduledTimer(
                    timeInterval: 1,
                    target: self,
                    selector: #selector(self.updatePlayingTime),
                    userInfo: nil,
                    repeats: true
                )
            }
        } else {
            self.controlButton.setImage(UIImage(named: "play"), for: .normal)

            // Stop timer
            self.playingTimeTimer?.invalidate()
            self.playingTimeTimer = nil
        }
    }
    
    @IBAction func backwardAction(_ sender: Any) {
        let time = self.manager.player.currentTime - 30
        self.manager.player.currentTime = time > 0 ? time : 0
        self.updatePlayingTime()
    }
    @IBAction func forewardAction(_ sender: Any) {
        self.manager.player.currentTime += 30
        self.updatePlayingTime()
    }
    
    @objc func audioDidStopped() {
        self.controlButton.setImage(UIImage(named: "play"), for: .normal)
        // Stop timer
        self.playingTimeTimer?.invalidate()
        self.playingTimeTimer = nil

        self.updatePlayingTime()
    }
    
    @objc func updatePlayingTime() {
        self.playTimeSlider.value = Float(self.manager.player.currentTime)
        self.playTimeLabel.text = self.formatTimeString(self.manager.player.currentTime)
    }
    
    func formatTimeString(_ d: Double) -> String {
        let h : Int = Int(d / 3600)
        let m : Int = Int((d - Double(h) * 3600) / 60)
        let s : Int = Int(d - 3600 * Double(h)) - m * 60
        let str = String(format: "%02d:%02d:%02d", h, m, s)

        return str
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        self.playingTimeTimer?.invalidate()
        self.playingTimeTimer = nil
        self.manager.player.stop()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
