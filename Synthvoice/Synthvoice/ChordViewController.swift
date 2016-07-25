//
//  ChordViewController.swift
//  Project2Demo
//
//  Created by Maya Saxena on 4/2/15.
//  Copyright (c) 2015 Maya Saxena. All rights reserved.
//

import UIKit

class ChordViewController: UIViewController {
    
    
    @IBOutlet var chordRegions: [UIView]!
    
    var currentRegion: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let rightRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        rightRecognizer.direction = .Right;
        self.view.addGestureRecognizer(rightRecognizer)
        
        
        for chordRegion in chordRegions {
            let tapRec: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "setActiveRegion:")
            chordRegion.addGestureRecognizer(tapRec)
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func swipeRight(recognizer : UISwipeGestureRecognizer) {

        if (recognizer.locationInView(view).x < 50) {
            self.performSegueWithIdentifier("RightSegue", sender: self)
        }
    }
    
    func setActiveRegion(recognizer: UITapGestureRecognizer) {
        resetRegions()
        recognizer.view?.backgroundColor = UIColor(red: 0.0, green: 0.1, blue: 0.5, alpha: 0.2)
        currentRegion = recognizer.view!
    }

    
    func resetRegions() {
        for chordRegion in chordRegions {
            chordRegion.backgroundColor = UIColor.clearColor()
        }
    }
    
    
    @IBAction func addChord(sender: AnyObject) {
        if (currentRegion != nil) {
            let button = sender as UIButton
            
            if (currentRegion.subviews.count == 0) {
                var newChord = UIView(frame: CGRectMake(0, button.frame.minY, currentRegion.frame.width, button.frame.height))
                newChord.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.85, alpha: 1.0)
                newChord.layer.borderWidth = 2.0;
                currentRegion.addSubview(newChord)
                
            } else {
                let region = currentRegion.subviews.first! as UIView;
                view.bringSubviewToFront(region)
                region.center.y = button.center.y

                
            }
        }
        
        view.setNeedsDisplay()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
    }

}
