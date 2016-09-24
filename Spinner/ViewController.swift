//
//  ViewController.swift
//  Spinner
//
//  Created by Daniel Sykes-Turner on 10/09/2016.
//  Copyright © 2016 UniverseApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lblSelectedSlice:UILabel!
    @IBOutlet var btnSettings:UIButton!
    
    var spinner:Spinner! = Spinner()
    var sliceSelectorImage:UIImageView! = UIImageView()
    
    var startAngle:CGFloat = 0.0
    var currentAngle:CGFloat = 0.0
    var lastAngles:[CGFloat] = [CGFloat]()
    var differenceAngle:CGFloat = 0.0
    
    var spinTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Reset the spinner with its latest settings
        if spinTimer != nil {
            spinTimer?.invalidate()
        }
        createSpinner()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        if spinTimer != nil {
            spinTimer?.invalidate()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Stop the spinner when the screen is tapped
        if spinTimer != nil {
            spinTimer?.invalidate()
        }
    }
    
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        
        // Take the finger x/y, and the rotation point of the spinner
        let location = recognizer.location(in: self.view)
        let fromCenter = CGPoint.init(x: location.x-self.spinner.center.x, y: location.y-self.spinner.center.y)
        var startPoint:CGPoint

        // Keep the adjusted start finger point positive
        if location.y > self.spinner.center.y {
            startPoint = CGPoint.init(x: self.spinner.center.x, y: self.spinner.center.y-abs(fromCenter.y))
        } else {
            startPoint = CGPoint.init(x: self.spinner.center.x, y: self.spinner.center.y+abs(fromCenter.y))
        }
        
        // Calcualte the current starting angle of the spinner
        currentAngle = atan2((location.x-startPoint.x), (location.y-startPoint.y))
        
        // If this is a touch down event, first stop any spinning, then update the start angle
        if recognizer.state == UIGestureRecognizerState.began {
            
            if spinTimer != nil {
                spinTimer?.invalidate()
            }
            
            let currentDegree = atan2f(Float(spinner.transform.b), Float(spinner.transform.a))
            startAngle = currentAngle + CGFloat(currentDegree)
        }
        
//        print("current: \(currentAngle)")
        
        // Rotate the spinner
        self.spinner.transform = CGAffineTransform.init(rotationAngle: startAngle-currentAngle)
        
        // Keep the currentAngle positive for the velocity calculation
        if currentAngle >= 0 {
            lastAngles.append(currentAngle)
        } else {
            lastAngles.append(currentAngle+CGFloat(2*M_PI)) // Add 2*PI to each angle, shifting the circle, so we don't have to deal with any negative values
        }
        // Take the last 5 movement points to form an average
        if lastAngles.count > 5 {
            lastAngles.removeFirst(1)
        }
        
        // Continue the spinning when the finger is lifted off
        if recognizer.state == UIGestureRecognizerState.ended {
            
            // Calculate the average difference of angles from the last few points
            var difference:CGFloat = 0
            for i in 0..<(lastAngles.count-1) {
                let a1 = lastAngles[i]
                let a2 = lastAngles[i+1]
                
                difference += (a1-a2)
            }
            differenceAngle = CGFloat(difference / CGFloat(lastAngles.count-1))
            
            // Adjust the quality of the spin movement. this will also affed the friction
            let quality:CGFloat = 3.0
            differenceAngle *= quality
            
            spinTimer = Timer.scheduledTimer(timeInterval: Double(0.01/quality), target: self, selector: #selector(spin), userInfo: nil, repeats: true)
        }
        
        // Update the current slice text indicator
        refreshSelectedSlice()
    }
    
    func spin() {
        
        // Keep spinning, minus a small amount of friction
        differenceAngle *= CGFloat(appDelegate().friction)
//        print("difference: \(differenceAngle)")
        
        // Stop spinning when the rotation becomes too slow
        if differenceAngle < 0.0001 && differenceAngle > -0.0001 {
            spinTimer?.invalidate()
        }
        
        // Update the spinner's angle
        currentAngle -= differenceAngle
        self.spinner.transform = CGAffineTransform.init(rotationAngle: startAngle-currentAngle)
        
        // Update the current slice text indicator
        refreshSelectedSlice()
    }
    
    func refreshSelectedSlice() {
        
        let thisSlice = spinner.sliceTextAtDegree(degree: Double(startAngle-currentAngle) * (180.0/M_PI))
        lblSelectedSlice.text = thisSlice.text.uppercased()
    }
    
    func createSpinner() {
        
        if spinner.superview != nil {
            spinner.removeFromSuperview()
        }
        if sliceSelectorImage.superview != nil {
            sliceSelectorImage.removeFromSuperview()
        }
        
        var spinnerList = [String]()
        
        if appDelegate().selectedSpinnerIndex == 2 {
            for i in 0..<appDelegate().sections {
                spinnerList.append("\(i+1)")
            }
        } else {
            spinnerList = appDelegate().spinnerLists[appDelegate().selectedSpinnerIndex]
        }
                
        spinner = Spinner(frame: CGRect.init(x: 0, y: 0, width: appDelegate().radius*2, height: appDelegate().radius*2))
        spinner.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height+40)
        spinner.addSlices(names: spinnerList)
        view.insertSubview(spinner, belowSubview: btnSettings)
        
        sliceSelectorImage = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        sliceSelectorImage.center = CGPoint.init(x: view.frame.size.width/2, y:spinner.frame.origin.y-(sliceSelectorImage.frame.size.height/2-10))
        sliceSelectorImage.image = UIImage(named: "arrow")
        view.addSubview(sliceSelectorImage)
        
        startAngle = 0.0
        currentAngle = 0.0
        self.refreshSelectedSlice()
    }
}

