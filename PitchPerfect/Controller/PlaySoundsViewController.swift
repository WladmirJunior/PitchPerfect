//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Wladmir Edmar Silva Junior on 17/11/19.
//  Copyright © 2019 Wladmir Edmar Silva Junior. All rights reserved.
//

import UIKit
import AVFoundation

struct SettingsFields {
    static var rateMin : Float = 0.5
    static var rateMax : Float = 1.5
    static var pitchMin: Float = -1000
    static var pitchMax: Float = 1000
}

class PlaySoundsViewController: UIViewController {

    // MARK: - PROPERTIES
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    // MARK: - ACTIONS
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch ButtonType(rawValue: sender.tag)! {
        case .slow:
            playSound(rate: SettingsFields.rateMin)
        case .fast:
            playSound(rate: SettingsFields.rateMax)
        case .chipmunk:
            playSound(pitch: SettingsFields.pitchMax)
        case .vader:
            playSound(pitch: SettingsFields.pitchMin)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }

    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    // I can't apply the effects and save them to the file so I can share the processed audio with the effects, I would like some help with this, what do I need to do to apply the effects to the saved file?
    @IBAction func share(_ sender: Any) {
        let urlAudio = URL(fileURLWithPath: recordedAudioURL.path, isDirectory: false)
        let activityController = UIActivityViewController(activityItems: [urlAudio], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
}
