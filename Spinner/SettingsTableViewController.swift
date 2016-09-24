//
//  SettingsTableViewController.swift
//  Spinner
//
//  Created by Daniel Sykes-Turner on 18/09/2016.
//  Copyright © 2016 UniverseApps. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var txtRadius: UITextField!
    @IBOutlet weak var frictionSlider: UISlider!
    @IBOutlet weak var txtSections: UITextField!
    @IBOutlet weak var txtTextSize: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set bar button font
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "BodoniSvtyTwoOSITCTT-Book", size: 17)!], for: UIControlState.normal)
        self.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "BodoniSvtyTwoOSITCTT-Book", size: 17)!], for: UIControlState.normal)
        
        self.txtRadius.text = "\(appDelegate().radius!)"
        self.txtSections.text = "\(appDelegate().sections!)"
        self.txtTextSize.text = "\(appDelegate().textSize!)"
        
        switch appDelegate().friction {
        case 0.9999:
            frictionSlider.value = 1
        case 0.999:
            frictionSlider.value = 2
        case 0.993:
            frictionSlider.value = 3
        case 0.96:
            frictionSlider.value = 4
        case 0.9:
            frictionSlider.value = 5
        default:
            frictionSlider.value = 3
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Add the current checkmark
        let cell = tableView.cellForRow(at: IndexPath(row: appDelegate().selectedSpinnerIndex, section: 0))
        cell?.accessoryType = .checkmark
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderTouchUp() {
        
        frictionSlider.value = Float(Int(frictionSlider.value))
    }

    @IBAction func btnCloseTapped(_ sender: AnyObject) {
        
        // Find slider translated value
        let sliderValue = Int(frictionSlider.value)
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
        
        // Save and close
        appDelegate().radius = Int(txtRadius.text!)
        appDelegate().sections = Int(txtSections.text!)
        appDelegate().friction = friction
        appDelegate().textSize = Int(txtTextSize.text!)
        
        txtRadius.resignFirstResponder()
        txtSections.resignFirstResponder()
        txtTextSize.resignFirstResponder()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            if indexPath.row < appDelegate().spinnerLists.count {
                
                // Remove the previous checkmark
                let oldCell = tableView.cellForRow(at: IndexPath(row: appDelegate().selectedSpinnerIndex, section: 0))
                oldCell?.accessoryType = .none
                
                // Set the selected list
                appDelegate().selectedSpinnerIndex = indexPath.row
                
                // Add the new checkmark
                let newCell = tableView.cellForRow(at: indexPath)
                newCell?.accessoryType = .checkmark
                
            } else {
                // TODO: create new
            }
        }
    }
}
