//
//  SettingsFrictionTableViewCell.swift
//  Spinner
//
//  Created by Daniel Sykes-Turner on 24/9/16.
//  Copyright © 2016 UniverseApps. All rights reserved.
//

import UIKit

class SettingsFrictionTableViewCell: UITableViewCell {

    @IBOutlet var slider: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        switch appDelegate().friction {
        case 0.9999:
            slider.value = 1
        case 0.999:
            slider.value = 2
        case 0.993:
            slider.value = 3
        case 0.96:
            slider.value = 4
        case 0.9:
            slider.value = 5
        default:
            slider.value = 3
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func setNewValue() {
        
        slider.value = Float(Int(slider.value))
        
        // Find slider translated value
        let sliderValue = Int(slider.value)
        var friction = 0.0
        switch sliderValue {
        case 1:
            friction = 0.9999
        case 2:
            friction = 0.993
        case 3:
            friction = 0.99
        case 4:
            friction = 0.96
        case 5:
            friction = 0.9
        default:
            friction = 0.993
        }
        
        appDelegate().friction = friction
    }
}
