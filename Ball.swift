//
//  Ball.swift
//  BouncingBalls
//
//  Created by Venky Venkatakrishnan on 3/19/17.
//  Copyright © 2017 Venky Venkatakrishnan. All rights reserved.
//

import Foundation
import Cocoa

class  Ball
{
    
    var center: CGPoint
    var radius: CGFloat
    var lineColor: NSColor
    var fillColor: NSColor
    var xDirection: CGFloat
    var yDirection: CGFloat
    var path: NSBezierPath
    
    init(center: CGPoint, radius: CGFloat, color: NSColor)
    {
        self.center = center
        self.radius = radius
        self.lineColor = color
        self.fillColor = color
        self.xDirection = 1.0
        self.yDirection = 1.0
        
        let bounds: NSRect = NSRect(x: center.x - radius, y: center.y - radius, width: 2 * radius, height: 2 * radius)
        
        self.path = NSBezierPath(ovalIn: bounds)
    }
    
    func setRadius(radius: CGFloat)
    {
        self.radius = radius
        let bounds: NSRect = NSRect(x: center.x - radius, y: center.y - radius, width: 2 * radius, height: 2 * radius)
        
        self.path = NSBezierPath(ovalIn: bounds)
    }
    
    func draw()
    {
        
        lineColor.setStroke()
        fillColor.setFill()
        
        self.path.stroke()
        self.path.fill()
        
    }
    
    func move(dx: CGFloat, dy: CGFloat, contextRect: NSRect, collideFlag: Bool)
    {

        
        if (contextRect.maxX < (self.path.bounds.maxX)) ||
           (contextRect.minX > (self.path.bounds.minX)) ||
            collideFlag == true
        {
            xDirection = xDirection * -1.0
            
        }
        
        if (contextRect.maxY < (self.path.bounds.maxY)) ||
           (contextRect.minY > (self.path.bounds.minY)) ||
            collideFlag == true
        {
            yDirection = yDirection * -1.0
        }
    
        let transform: AffineTransform =  AffineTransform(translationByX: xDirection * dx, byY: yDirection * dy)
        
     
        self.path.transform(using: transform)
      
 
    }

    func collide(ball: Ball) -> Bool
    {
        if self.path.bounds.intersects(ball.path.bounds)
        {
            return true
        }
        return false
    }
    
 
   
}
