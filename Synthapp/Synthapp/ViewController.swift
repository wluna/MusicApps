//
//  ViewController.swift
//  Synthapp
//
//  Created by Maya Saxena on 2/10/15.
//  Copyright (c) 2015 Maya Saxena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var octaveLabel: UILabel!

    
    var duration:Int! = 2
    var note:Int! = 0
    var octave:Int! = 4
   
    
    let swipeRight = UISwipeGestureRecognizer()
    let swipeLeft = UISwipeGestureRecognizer()
    let swipeUp = UISwipeGestureRecognizer()
    let swipeDown = UISwipeGestureRecognizer()
    let doubleSwipeUp = UISwipeGestureRecognizer()
    let doubleSwipeDown = UISwipeGestureRecognizer()
    
    
    let notes = ["A", "B", "C", "D", "E", "F", "G"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteLabel.text = notes[note]
        durationLabel.text = String(duration)
        octaveLabel.text = String(octave)
        
        swipeRight.addTarget(self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        swipeView.addGestureRecognizer(swipeRight)
        
        swipeLeft.addTarget(self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        swipeView.addGestureRecognizer(swipeLeft)
        
        swipeUp.addTarget(self, action: "respondToSwipeGesture:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        swipeView.addGestureRecognizer(swipeUp)
        
        swipeDown.addTarget(self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        swipeView.addGestureRecognizer(swipeDown)
        
        doubleSwipeUp.addTarget(self, action: "respondToSwipeGesture:")
        doubleSwipeUp.numberOfTouchesRequired = 2;
        doubleSwipeUp.direction = UISwipeGestureRecognizerDirection.Up
        swipeView.addGestureRecognizer(doubleSwipeUp)

        doubleSwipeDown.addTarget(self, action: "respondToSwipeGesture:")
        doubleSwipeDown.numberOfTouchesRequired = 2;
        doubleSwipeDown.direction = UISwipeGestureRecognizerDirection.Down
        swipeView.addGestureRecognizer(doubleSwipeDown)
        
        swipeView.userInteractionEnabled = true
        
        
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                duration = (durationLabel.text?.toInt())! + 1
                durationLabel.text = String(duration)
                self.view.bringSubviewToFront(swipeView)
                UIView.animateWithDuration(1.0, animations: {
                    self.swipeView.bounds = CGRect(x: self.swipeView.bounds.minX, y: self.swipeView.bounds.minY, width: 500, height: self.swipeView.bounds.height)
                })
//                swipeGesture.view!.transform = CGAffineTransformScale(swipeGesture.view!.transform, 2, 1)
                
            case UISwipeGestureRecognizerDirection.Left:
                var durationInt = durationLabel.text?.toInt()
                duration = (durationLabel.text?.toInt())! - 1
                durationLabel.text = String(duration)
                self.view.bringSubviewToFront(swipeView)
                swipeGesture.view!.transform = CGAffineTransformScale(swipeGesture.view!.transform, 0.5, 1)
            case UISwipeGestureRecognizerDirection.Up:
                println("up")
                if(swipeGesture.numberOfTouches() == 2) {
                    println("double swipe up")
                }
                var noteInt = find(notes, noteLabel.text!)
                noteLabel.text = notes[(noteInt! + 1) % notes.count]
            case UISwipeGestureRecognizerDirection.Down:
                if(swipeGesture.numberOfTouches() == 2) {
                    println("double swipe down")
                }
                var noteInt = find(notes, noteLabel.text!)
                noteLabel.text = notes[(noteInt! - 1 + notes.count) % notes.count]
            default:
                break
            }
        }
    }
    

}

