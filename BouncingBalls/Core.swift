//
//  Core.swift
//  BouncingBalls
//
//  Created by Venky Venkatakrishnan on 3/21/17.
//  Copyright © 2017 Venky Venkatakrishnan. All rights reserved.
//

import Foundation
import Cocoa

func randomNumber(MIN: Int, MAX: Int)-> Int{
    return Int(arc4random_uniform(UInt32(MAX)) + UInt32(MIN));
}

var ColorNames: [NSColor] =
    [NSColor.red, NSColor.green, NSColor.gray, NSColor.purple, NSColor.blue, NSColor.brown]


func centerText(text str: String, origin: CGPoint, context: CGContext, radius r:CGFloat, angle theta: CGFloat, color c: NSColor, font:NSFont, slantAngle: CGFloat) {
    // *******************************************************
    // This draws the String str centred at the position
    // specified by the polar coordinates (r, theta)
    // i.e. the x= r * cos(theta) y= r * sin(theta)
    // and rotated by the angle slantAngle
    // *******************************************************
    
    // Set the text attributes
    let attributes = [NSForegroundColorAttributeName: c,
                      NSFontAttributeName: font]
    // Save the context
    context.saveGState()
    
    /*
    // Undo the inversion of the Y-axis (or the text goes backwards!)
    context.scaleBy(x: 1, y: -1)
    // Move the origin to the centre of the text (negating the y-axis manually)
    context.translateBy(x: r * cos(theta), y: -(r * sin(theta)))
    // Rotate the coordinate system
    context.rotate(by: -slantAngle) */
    // Calculate the width of the text
    let offset = str.size(withAttributes: attributes)
    // Move the origin by half the size of the text
    context.translateBy (x: -offset.width / 2, y: -offset.height / 2) // Move the origin to the centre of the text (negating the y-axis manually)
    // Draw the text
    str.draw(at: origin, withAttributes: attributes)
    // Restore the context
    context.restoreGState()
}
