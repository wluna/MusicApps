//
//  NoteButton.swift
//  Project2Demo
//
//  Created by Maya Saxena on 4/1/15.
//  Copyright (c) 2015 Maya Saxena. All rights reserved.
//

import UIKit

class NoteButton: UIButton {
    
    var posInScale:Int
    var midiNote:Int
    
    init (scalePos: Int, note:Int) {
        posInScale = scalePos
        midiNote = note
        super.init()
        
        self.layer.cornerRadius = (self.frame.size.width/3) * 2;
        self.clipsToBounds = true
    }

    required init(coder aDecoder: NSCoder) {
        posInScale = 0
        midiNote = 0
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = (self.frame.size.width/3) * 2;
        self.clipsToBounds = true
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    

    override func drawRect(rect: CGRect) {
        var ctx = UIGraphicsGetCurrentContext()
        CGContextAddEllipseInRect(ctx, rect)
        CGContextSetFillColorWithColor(ctx, UIColor.clearColor().CGColor)
        CGContextFillPath(ctx);

    }
    
    

}
