//
//  SettingsViewController.swift
//  PitchPerfect
//
//  Created by Wladmir Edmar Silva Junior on 17/11/19.
//  Copyright © 2019 Wladmir Edmar Silva Junior. All rights reserved.
//

import UIKit

enum Settings: Int {
    case rateMin = 0
    case rateMax
    case pitchMin
    case pitchMax
}

class SettingsViewController: UIViewController {

    // MARK: - PROPERTIES
    
    @IBOutlet weak var sliderRateMin: UISlider!
    @IBOutlet weak var sliderRateMax: UISlider!
    @IBOutlet weak var sliderPitchMin: UISlider!
    @IBOutlet weak var sliderPitchMax: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderRateMin.value = SettingsFields.rateMin
        sliderRateMax.value = SettingsFields.rateMax
        sliderPitchMin.value = SettingsFields.pitchMin
        sliderPitchMax.value = SettingsFields.pitchMax
        
    }

    // MARK: - ACTIONS
    
    @IBAction func changeSlideFor(_ sender: UISlider) {
        switch Settings(rawValue: sender.tag)! {
        case .rateMin:
            SettingsFields.rateMin = sender.value
        case .rateMax:
            SettingsFields.rateMax = sender.value
        case .pitchMin:
            SettingsFields.pitchMin = sender.value
        case .pitchMax:
            SettingsFields.pitchMax = sender.value
        }
    }
    
}
