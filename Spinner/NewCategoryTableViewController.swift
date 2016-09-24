//
//  NewCategoryTableViewController.swift
//  Spinner
//
//  Created by Daniel Sykes-Turner on 18/09/2016.
//  Copyright © 2016 UniverseApps. All rights reserved.
//

import UIKit

class NewCategoryTableViewController: UITableViewController, NewCategoryTableViewCellDelegate {

    var items:[String]! = [String]()
    var categoryName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add a save button
        let rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(saveAndExit))
        rightButton.title = "Save"
        rightButton.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "BodoniSvtyTwoOSITCTT-Book", size: 17)!], for: UIControlState.normal)
        self.navigationController?.navigationBar.topItem?.setRightBarButton(rightButton, animated: false)
        self.navigationItem.setRightBarButton(rightButton, animated: false)
        
        // Set the title
        self.navigationItem.title = "New Category"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let cell = tableView.cellForRow(at: IndexPath(row:0, section:0)) as! NewCategoryTableViewCell
        cell.textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveAndExit() {
        
        // TODO: not currently viable
        
        var newList = [String]()
        for i in 1 ..< tableView.numberOfRows(inSection: 0) {
            let cell = tableView.cellForRow(at: IndexPath(row:i, section:0)) as! NewCategoryTableViewCell
            newList.append(cell.textField.text!)
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count + 2 // 1 for the category name, 1 for the next category item
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:NewCategoryTableViewCell
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "newCategoryNameCell", for: indexPath) as! NewCategoryTableViewCell
            
            if let n = categoryName {
                cell.textField.text = n
            } else {
                cell.textField.text = ""
            }
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "newCategoryItemCell", for: indexPath) as! NewCategoryTableViewCell
            
            if indexPath.row < items.count+1 {
                let n = items[indexPath.row-1]
                cell.textField.text = n
            } else {
                cell.textField.text = ""
            }
        }
        cell.delegate = self
        cell.rowIndex = indexPath.row
        
        return cell
    }
 
    
    // MARK: - NewCategoryTableViewCellDelegate
    func didAddItem(index: Int) {
        
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row:items.count+1, section:0), at: UITableViewScrollPosition.bottom, animated: true)
        
        let cell = tableView.cellForRow(at: IndexPath(row:items.count+1, section:0)) as! NewCategoryTableViewCell
        cell.textField.becomeFirstResponder()
    }
    
    func didChangeItem(item: String, index: Int) {
        
        if index == 0 {
            categoryName = item
            return
        }
        
        if index-1 >= items.count {
            items.append(item)
        } else {
            items[index-1] = item
        }
    }
}
