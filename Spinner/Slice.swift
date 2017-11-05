//
//  Slice.swift
//  Spinner
//
//  Created by Daniel Sykes-Turner on 10/09/2016.
//  Copyright © 2016 UniverseApps. All rights reserved.
//

import UIKit

class Slice: UIView {
    
    var slice:UIView! = UIView()
    var text:String! = ""

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup the slice and our empty background
        self.backgroundColor = UIColor.clear
        
        slice = UIView(frame: CGRect.init(x: frame.width/2, y: frame.height/2, width: frame.width/2, height: frame.height/2))
        addSubview(slice)
    }

    func cutSlice(number: Int, total: Int, colour: UIColor, text: String) {
        
        slice.backgroundColor = colour
        
        let step = 360.0/Double(total)
        let rotationSlice = (90.0-step)
        
        // Create the label and set the anchor point to y's center
        self.text = text
        let label = UILabel()
        label.layer.anchorPoint = CGPoint.init(x: 0, y: 0.5)
        label.frame = CGRect.init(x: 0, y: -250, width: frame.width/2-8, height: 500) // height should be large enough that no text gets cut off
        label.text = text.uppercased()
        label.font = UIFont.init(name: "BodoniSvtyTwoOSITCTT-Book", size: CGFloat(appDelegate().textSize))
        label.textAlignment = NSTextAlignment.right
        label.shadowColor = UIColor(white: 0.8, alpha: 1)
        label.shadowOffset = CGSize(width: 0.3, height: 0.3)
        
        // Rotate the label so it is half way between the remaining rectangle's area
        label.transform = CGAffineTransform.init(rotationAngle: CGFloat((rotationSlice+(90-rotationSlice)/2) * (Double.pi/180.0)))
        slice.addSubview(label)
        
        // Create the mask
        let innerFrame = CGRect(x: 0, y: 0, width: frame.width/2, height: frame.height/2)
        let circlePath = UIBezierPath(rect: innerFrame)
        let maskLayer = CAShapeLayer()
        maskLayer.path = circlePath.cgPath
        maskLayer.fillColor = UIColor.green.cgColor
        
        // Rotate it to the correct cut
        let maskTransform = CGAffineTransform.init(rotationAngle: CGFloat((rotationSlice) * (Double.pi/180.0)))
        maskLayer.transform = CATransform3DMakeAffineTransform(maskTransform)
        
        slice.layer.addSublayer(maskLayer)
        slice.layer.mask = maskLayer
        
        // Rotate the slice to the correct position
        transform = CGAffineTransform.init(rotationAngle: CGFloat(step*Double(number) * (Double.pi/180.0)))
    }
}
