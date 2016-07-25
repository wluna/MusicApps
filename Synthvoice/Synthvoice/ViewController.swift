//
//  ViewController.swift
//  Project2Demo
//
//  Created by Maya Saxena on 3/31/15.
//  Copyright (c) 2015 Maya Saxena. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    
    @IBOutlet weak var drums: UIButton!
    
    @IBOutlet var buttons: [NoteButton]?
    var currentRootMidi: Int

    required init(coder aDecoder: NSCoder) {
        currentRootMidi = 48
        super.init(coder: aDecoder)
        
    }
    
    @IBOutlet weak var sustain: UIButton!
    
    @IBOutlet weak var tempo: UISlider!
    @IBOutlet var boardView: UIView!
    
    var currentNotes: [Int] = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        var path = NSBundle.mainBundle().resourcePath! + "/"
        var file = "piano_1.sf2"
        PdBase.sendList(["set", path + file], toReceiver: "your_soundfonts_receiver")
        println("change to piano")
        
        
        path = NSBundle.mainBundle().resourcePath! + "/"
        file = "banjo_1.sf2"
        PdBase.sendList(["set", path + file], toReceiver: "your_soundfonts_receiver")
        println("change to banjo")
        */
        
        let leftRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
        leftRecognizer.direction = .Left;
        leftRecognizer.cancelsTouchesInView = false;
        self.view.addGestureRecognizer(leftRecognizer)
        
        let rightRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        rightRecognizer.direction = .Right;
        rightRecognizer.cancelsTouchesInView = false;
        
        self.view.addGestureRecognizer(rightRecognizer)
        
        for button in buttons! {
            button.midiNote = button.tag
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // MARK: - Gesture Recognizer Actions
    
    func swipeLeft(recognizer : UISwipeGestureRecognizer) {
//        if (recognizer.state == .Ended) {
//            self.performSegueWithIdentifier("LeftSegue", sender: self)
//        }
        
        if(recognizer.locationInView(boardView).x > boardView.frame.width - 50) {
            self.performSegueWithIdentifier("LeftSegue", sender: self)
        }
        
    }
    

    func swipeRight(recognizer : UISwipeGestureRecognizer) {
//        if (recognizer.state == .Ended) {
//            self.performSegueWithIdentifier("RightSegue", sender: self)
//        }
        
        if(recognizer.locationInView(boardView).x < 50) {
            self.performSegueWithIdentifier("RightSegue", sender: self)
        }
    }
    
    
    
    

    // MARK: - Board Note Playing Functions

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for button in self.buttons! {
            
            for touch in touches {
                
                let point = touch.locationInView(boardView);
                
                if (button.frame.contains(point) && !contains(currentNotes, button.midiNote)){
                    
                    println(button.midiNote)
                    
                    PdBase.sendFloat(Float(button.midiNote), toReceiver: "note")
                    currentNotes.append(button.midiNote)
                    
                    button.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.5)
                    
                } else if (!contains(currentNotes, button.midiNote)){
                    
                    button.backgroundColor = UIColor.clearColor()
                    
                }
            }
        }

    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for button in self.buttons! {
            
            for touch in touches {
                
                let point = touch.locationInView(boardView);
                
                if (button.frame.contains(point) && !contains(currentNotes, button.midiNote)){
                    
                    
                    PdBase.sendFloat(Float(button.midiNote), toReceiver: "note")
                    PdBase.sendFloat(1, toReceiver: "volume");
                    currentNotes.append(button.midiNote)

                    button.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.5)
                    
                } else if (button.frame.contains(point) && contains(currentNotes, button.midiNote)) {
                
                    button.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.5)
                    
                } else if (!button.frame.contains(point) && contains(currentNotes, button.midiNote)){
                    
                    if (currentNotes.count == 1) {
                        button.backgroundColor = UIColor.clearColor()
                        currentNotes.removeAll(keepCapacity: false)
                    }
        
                    
                }
            }
            
        }
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        currentNotes.removeAll(keepCapacity: false)

        for button in self.buttons! {
     
                button.backgroundColor = UIColor.clearColor()
            
        }
    }
    
    @IBAction func changeRoot(sender: AnyObject) {
        let delta = sender.tag - currentRootMidi
        currentRootMidi = sender.tag;
        
        for button in buttons! {
            button.midiNote += delta
            button.setTitle(noteFromMidi(button.midiNote), forState: .Normal)
            button.sizeToFit()
        }
        
    }
    
    

    @IBAction func toMinor(sender: AnyObject) {
        for button in buttons! {
            if ((button.midiNote - currentRootMidi) % 12 == 4) {
                button.midiNote--;
            } else if ((button.midiNote - currentRootMidi) % 12 == 9) {
                button.midiNote--;
            } else if ((button.midiNote - currentRootMidi) % 12 == 11) {
                button.midiNote--;
            }
            button.setTitle(noteFromMidi(button.midiNote), forState: .Normal)
            button.sizeToFit()
        }
        
        
    }
    
  

    
    func noteFromMidi(note: Int) -> String {
        var remainder = note % 12
        switch remainder {
        case 0:
            return "C"
        case 1:
            if (currentRootMidi % 12 == 8) {
                    return "D♭"
            } else {
                    return "C#"
            }
        case 2:
            return "D"
        case 3:
            if (currentRootMidi % 12 == 3 ||
                currentRootMidi % 12 == 8 ||
                currentRootMidi % 12 == 10) {
                    return "E♭"
            } else {
                    return "D#"
            }
        case 4:
            return "E"
        case 5:
            return "F"
        case 6:
            return "F#"
        case 7:
            return "G"
        case 8:
            if (currentRootMidi % 12 == 3 ||
                currentRootMidi % 12 == 8) {
                    return "A♭"
            } else {
                    return "G#"
            }
        case 9:
            return "A"
        case 10:
            if (currentRootMidi % 12 == 1 ||
                currentRootMidi % 12 == 6 ||
                currentRootMidi % 12 == 11) {
                    return "A#"
            } else {
                    return "B♭"
            }
        case 11:
            return "B"
        default:
            break
            
        }
        return " "
    }
 
    
    @IBAction func sustainAction(sender: AnyObject) {
        
        PdBase.sendBangToReceiver("sustain")
        NSLog("sustain")
    }
    
    @IBAction func drumsAction(sender: AnyObject) {
        
        PdBase.sendBangToReceiver("drums")
        NSLog("drums")
    }

    @IBAction func tempoAction(sender: AnyObject) {
        
    }
}
