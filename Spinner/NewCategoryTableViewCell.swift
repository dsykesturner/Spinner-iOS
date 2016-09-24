//
//  NewCategoryTableViewCell.swift
//  Spinner
//
//  Created by Daniel Sykes-Turner on 18/09/2016.
//  Copyright © 2016 UniverseApps. All rights reserved.
//

import UIKit

protocol NewCategoryTableViewCellDelegate: class {
    func didAddItem(index: Int)
    func didChangeItem(item: String, index: Int)
}

class NewCategoryTableViewCell: UITableViewCell {

    weak var delegate:NewCategoryTableViewCellDelegate?
    
    @IBOutlet var textField: UITextField!
    var rowIndex:Int! = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func textFieldDidReturn() {
    
        delegate!.didAddItem(index: rowIndex)
    }
    
    @IBAction func textFieldDidType() {
        
        delegate!.didChangeItem(item: textField.text!, index: rowIndex)
    }
}
