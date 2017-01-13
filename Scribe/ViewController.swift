//
//  ViewController.swift
//  Scribe
//
//  Created by Kimar Arakaki Neves on 2016-12-07.
//  Copyright © 2016 Kimar. All rights reserved.
//

import AVFoundation
import Speech
import UIKit

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var tanscrptionTextField: UITextView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activitySpinner.isHidden = true
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "Audio", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    } catch {
                        print("Error!")
                    }
                    
                    let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("There was an error: \(error)")
                        } else {
                            self.tanscrptionTextField.text = result?.bestTranscription.formattedString
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
}

