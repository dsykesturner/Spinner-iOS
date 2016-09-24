//
//  Spinner.swift
//  Spinner
//
//  Created by Daniel Sykes-Turner on 10/09/2016.
//  Copyright © 2016 UniverseApps. All rights reserved.
//

import UIKit

class Spinner: UIView {

    var circleMask:UIView! = UIView()
    var slices:[Slice] = [Slice]()
    var colours:[UIColor] = [UIColor]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
 
    func setup() {
        
        // Setup the possible colours
        colours.append(UIColor(hex: 0xF80007)) // red
        colours.append(UIColor(hex: 0xFA65B3)) // pink
        colours.append(UIColor(hex: 0xFFFF12)) // yellow
        colours.append(UIColor(hex: 0x22FF08)) // green
        colours.append(UIColor(hex: 0x16B2FE)) // blue
        colours.append(UIColor(hex: 0xFA6B0A)) // orange
        colours.append(UIColor(hex: 0xB064FF)) // purple
        
        colours.append(UIColor(hex: 0xFFFF12)) // yellow
        colours.append(UIColor(hex: 0xFA65B3)) // pink
        colours.append(UIColor(hex: 0xF80007)) // red
        colours.append(UIColor(hex: 0x16B2FE)) // blue
        colours.append(UIColor(hex: 0xFA6B0A)) // orange
        colours.append(UIColor(hex: 0xB064FF)) // purple
        colours.append(UIColor(hex: 0x22FF08)) // green
        
        colours.append(UIColor(hex: 0xFA65B3)) // pink
        colours.append(UIColor(hex: 0x16B2FE)) // blue
        colours.append(UIColor(hex: 0xF80007)) // red
        colours.append(UIColor(hex: 0xFA6B0A)) // orange
        colours.append(UIColor(hex: 0x22FF08)) // green
        colours.append(UIColor(hex: 0xFFFF12)) // yellow
        colours.append(UIColor(hex: 0xB064FF)) // purple
        
        self.backgroundColor = UIColor.black
        
        // Add a circle mask
        let innerFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let circlePath = UIBezierPath(roundedRect: innerFrame, cornerRadius: innerFrame.width)
        let maskLayer = CAShapeLayer()
        maskLayer.path = circlePath.cgPath
        maskLayer.fillColor = UIColor.green.cgColor
        
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
    func addSlices(names: [String]) {
        
        for i in 0..<names.count {
            
            let colour = colours[i%colours.count]
            
            // Create the slice
            let s = Slice(frame: CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height))
            s.cutSlice(number: i, total: names.count, colour: colour, text: names[i])
            addSubview(s)
            
            // Add to our list
            slices.append(s)
        }
    }
    
    func sliceTextAtDegree(degree: Double) -> Slice {
        
        let step = 360.0/Double(slices.count)
        
        // Reset the degree to a positive value
        var resetDegree = degree
        while resetDegree < 0 {
            resetDegree += 360.0
        }
        
        // Subtract half a step from the given degree so the slice edges are on the edge not the center
        let degree = resetDegree+180
//        print("deg: \(degree)")
        
        var stepNumber = 0
        
        // Calculate the step
        if degree < 0 {
            stepNumber = Int((360.0+degree)/step)
        } else {
            stepNumber = Int(degree/step)
        }
        
        // Adjust
        stepNumber -= 1
        
        // Keep the step within bounds
        if stepNumber >= slices.count {
            stepNumber = stepNumber % slices.count
        }
        while stepNumber < 0 {
            stepNumber += slices.count
        }
        
//        print(stepNumber)
        
        // Slice number is reversed, so invert it for retrival
        let adjustedStepNumber = slices.count-stepNumber-1
//        print(adjustedStepNumber)
        
        return slices[adjustedStepNumber]
    }
}
