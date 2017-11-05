//
//  SettingsRadiusTableViewCell.swift
//  Spinner
//
//  Created by Daniel Sykes-Turner on 24/9/16.
//  Copyright © 2016 UniverseApps. All rights reserved.
//

import UIKit

class SettingsRadiusTableViewCell: UITableViewCell {

    @IBOutlet var radius: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        radius.text = "\(appDelegate().radius!)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func setNewValue() {
        
        appDelegate().radius = Int(radius.text!)
    }
}
