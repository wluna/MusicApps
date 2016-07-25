//
//  HelpViewController.swift
//  Project2Demo
//
//  Created by Maya Saxena on 4/1/15.
//  Copyright (c) 2015 Maya Saxena. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    @IBOutlet var effectsView: UIView!
    
    @IBOutlet weak var bFlute: UIButton!
    @IBOutlet weak var piano: UIButton!
    @IBOutlet weak var mFlute: UIButton!
    @IBOutlet weak var age: UIButton!
    @IBOutlet weak var pad: UIButton!
    @IBOutlet weak var organ: UIButton!
    @IBOutlet weak var banjo: UIButton!
    
    
    @IBAction func pianoPress(sender: AnyObject) {
        PdBase.sendFloat(1, toReceiver: "patch")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let leftRecognizer: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "swipeLeft:")
//        leftRecognizer.edges = UIRectEdge.Right
//        self.view.addGestureRecognizer(leftRecognizer)
        
        let leftRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
        leftRecognizer.direction = .Left;
        self.view.addGestureRecognizer(leftRecognizer)
        
//        let rightRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
//        rightRecognizer.direction = .Right;
//        self.view.addGestureRecognizer(rightRecognizer)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func swipeLeft(recognizer : UISwipeGestureRecognizer) {
        //        if (recognizer.state == .Ended) {
        //            self.performSegueWithIdentifier("LeftSegue", sender: self)
        //        }
        
        
        if(recognizer.locationInView(effectsView).x > effectsView.frame.width - 50) {
            self.performSegueWithIdentifier("LeftSegue", sender: self)
        }
        
    }

    
//    func swipeRight(recognizer : UISwipeGestureRecognizer) {
//        //        if (recognizer.state == .Ended) {
//        //            self.performSegueWithIdentifier("RightSegue", sender: self)
//        //        }
//        
//        if(recognizer.locationInView(boardView).x < 50) {
//            self.performSegueWithIdentifier("RightSegue", sender: self)
//        }
//    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
    }

}
