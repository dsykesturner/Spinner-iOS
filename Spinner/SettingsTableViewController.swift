//
//  SettingsTableViewController.swift
//  Spinner
//
//  Created by Daniel Sykes-Turner on 18/09/2016.
//  Copyright © 2016 UniverseApps. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Add the current checkmark
        let cell = tableView.cellForRow(at: IndexPath(row: appDelegate().selectedSpinnerIndex, section: 0))
        cell?.accessoryType = .checkmark
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Set the right button bar
        let rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(close))
        rightButton.title = "Done"
        self.navigationController?.navigationBar.topItem?.setRightBarButton(rightButton, animated: false)
        self.navigationItem.setRightBarButton(rightButton, animated: false)
        
        // Set the left button bar
        let leftButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(toggleEditing))
        leftButton.title = "Edit"
        self.navigationController?.navigationBar.topItem?.setLeftBarButton(leftButton, animated: false)
        self.navigationItem.setLeftBarButton(leftButton, animated: false)
        
        // Set bar button font
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.setTitleTextAttributes([ NSAttributedStringKey.font: UIFont(name: "BodoniSvtyTwoOSITCTT-Book", size: 17)!], for: UIControlState.normal)
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem?.setTitleTextAttributes([ NSAttributedStringKey.font: UIFont(name: "BodoniSvtyTwoOSITCTT-Book", size: 17)!], for: UIControlState.normal)
        self.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "BodoniSvtyTwoOSITCTT-Book", size: 17)!], for: UIControlState.normal)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func close() {
        
        self.dismiss(animated: true, completion: nil)
    }
   
    @objc func toggleEditing () {
        
        tableView.isEditing = !tableView.isEditing
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return appDelegate().spinnerLists.count+1
        } else {
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = UITableViewCell()
        
        if indexPath.section == 0 {
            
            if indexPath.row == tableView.numberOfRows(inSection: 0)-1 {
                cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesAddNew")!
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCustom")!
                cell.textLabel?.text = appDelegate().spinnerLists[indexPath.row].keys.first!
            }
            
        } else {
            
            if indexPath.row == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "FineDetailsRadius") as! SettingsRadiusTableViewCell
            } else if indexPath.row == 1 {
                cell = tableView.dequeueReusableCell(withIdentifier: "FineDetailsFriction") as! SettingsFrictionTableViewCell
            } else if indexPath.row == 2 {
                cell = tableView.dequeueReusableCell(withIdentifier: "FineDetailsTextSize") as! SettingsTextSizeTableViewCell
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return (indexPath.section == 0 && indexPath.row <= appDelegate().spinnerLists.count-1)
    }
    
    
    
    // MARK: - UITableViewDelegate
    
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

                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewCategoryTableViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        
        print(action)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        appDelegate().spinnerLists.remove(at: indexPath.row)
        
        tableView.reloadData()
        
        // Re-alight the selected cell
        appDelegate().selectedSpinnerIndex = 0
        let cell = tableView.cellForRow(at: IndexPath(row: appDelegate().selectedSpinnerIndex, section: 0))
        cell?.accessoryType = .checkmark
    }
}
