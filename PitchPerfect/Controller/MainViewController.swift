//
//  MainViewController.swift
//  PitchPerfect
//
//  Created by Wladmir Edmar Silva Junior on 17/11/19.
//  Copyright © 2019 Wladmir Edmar Silva Junior. All rights reserved.
//

import UIKit
import AVFoundation

struct Constants {
    public static let segueIdentifier = "stopRecordingSegue"
    public static let fileName = "record.wav"
    public static let startRecordText = "Tap to start recording"
    public static let stopRecordText = "Tap to finish recording"
}

class MainViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    
    private var audioRecorder: AVAudioRecorder!
    private var isRecording: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isRecording = false
        setRecording(isRecording)
    }
    
    // MARK: - ACTIONS
    
    @IBAction func recordAudio(_ sender: UIButton) {
        isRecording = !isRecording
        setRecording(isRecording)

        if isRecording {
            startRecordingAudio()
        } else {
            stopRecordingAudio()
        }
    }
    
    // MARK: - PRIVATE API
    
    private func setRecording(_ isRecording: Bool) {
        if isRecording {
            recordingLabel.text = Constants.stopRecordText
            recordButton.setImage(UIImage(named: "Stop"), for: .normal)
        } else {
            recordButton.setImage(UIImage(named: "Record"), for: .normal)
            recordingLabel.text = Constants.startRecordText
        }
    }
    
    private func startRecordingAudio() {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = Constants.fileName
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    private func stopRecordingAudio() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false, options: [])
    }
    
    
    // MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier {
            let destinationViewController = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            destinationViewController.recordedAudioURL = recordedAudioURL
        }
    }
}

extension MainViewController: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: Constants.segueIdentifier, sender: audioRecorder.url)
        } else {
            print("recordingwas not successful")
        }
    }
}
