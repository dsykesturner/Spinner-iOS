//
//  ViewController.swift
//  Spinner
//
//  Created by Daniel Sykes-Turner on 10/09/2016.
//  Copyright © 2016 UniverseApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var spinner:UIView!
    
    var startAngle:CGFloat = 0.0
    var currentAngle:CGFloat = 0.0
    var lastAngles:[CGFloat] = [CGFloat]()
    var differenceAngle:CGFloat = 0.0
    
    var spinTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if spinTimer != nil {
            spinTimer?.invalidate()
        }
    }
    
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        
//        let translation = recognizer.translation(in: self.view)
        let location = recognizer.location(in: self.view)
        let fromCenter = CGPoint.init(x: location.x-self.spinner.center.x, y: location.y-self.spinner.center.y)
        
        var startPoint:CGPoint
        var x2 = fromCenter.x, y2 = fromCenter.y
        if x2 < 0 {
            x2 *= -1
        }
        if y2 < 0 {
            y2 *= -1
        }
        if location.y > self.spinner.center.y {
            startPoint = CGPoint.init(x: self.spinner.center.x, y: self.spinner.center.y-y2)
        } else {
            startPoint = CGPoint.init(x: self.spinner.center.x, y: self.spinner.center.y+y2)
        }
        
        print("\(startPoint), \(location)")
        
        

        currentAngle = atan2((location.x-startPoint.x), (location.y-startPoint.y))
        
        if recognizer.state == UIGestureRecognizerState.began {
            
            if spinTimer != nil {
                spinTimer?.invalidate()
            }
            
            let currentDegree = atan2f(Float(spinner.transform.b), Float(spinner.transform.a))
            startAngle = currentAngle + CGFloat(currentDegree)
        }
        
        print(currentAngle)
        
        self.spinner.transform = CGAffineTransform.init(rotationAngle: startAngle-currentAngle)
        
        lastAngles.append(currentAngle)
        if lastAngles.count > 5 {
            lastAngles.removeFirst(1)
        }
        
        if recognizer.state == UIGestureRecognizerState.ended {
            
            var difference:CGFloat = 0
            for i in 0..<(lastAngles.count-1) {
                let a1 = lastAngles[i]
                let a2 = lastAngles[i+1]
                
                difference += (a1-a2)
            }
            
            differenceAngle = CGFloat(difference / CGFloat(lastAngles.count-1))
            
            let quality:CGFloat = 3.0
            differenceAngle /= quality
            spinTimer = Timer.scheduledTimer(timeInterval: Double(0.01/quality), target: self, selector: #selector(spin), userInfo: nil, repeats: true)
        }
    }
    
    func spin() {
        
        differenceAngle *= 0.998
        print("difference: \(differenceAngle)")
        
        if differenceAngle < 0.0001 && differenceAngle > -0.0001 {
            spinTimer?.invalidate()
        }
        
        currentAngle -= differenceAngle
        self.spinner.transform = CGAffineTransform.init(rotationAngle: startAngle-currentAngle)

//        currentAngle += 0.001
//        print(currentAngle)
//        self.spinner.transform = CGAffineTransform.init(rotationAngle: currentAngle)
    }
    
    func calculateAngle(fromCenter: CGPoint) -> Double {
        
        // calculate starting angle
        if fromCenter.x > 0 {
            // right side
            if fromCenter.x > 0 {
                // top side
                if fromCenter.x > fromCenter.y {
                    // center side
                    
                    
                } else {
                    // top side
                }
            } else {
                // bottom side
                if fromCenter.x > fromCenter.y {
                    // center side
                } else {
                    // bottom side
                }
            }
        } else {
            // left side side
            if fromCenter.x > 0 {
                // top side
                if fromCenter.x > fromCenter.y {
                    // center side
                } else {
                    // top side
                }
            } else {
                // bottom side
                if fromCenter.x > fromCenter.y {
                    // center side
                } else {
                    // bottom side
                }
            }
        }
        
        return 0.0
    }

}

