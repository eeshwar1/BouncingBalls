//
//  BouncingBallsView.swift
//  BouncingBalls
//
//  Created by Venky Venkatakrishnan on 3/19/17.
//  Copyright © 2017 Venky Venkatakrishnan. All rights reserved.
//

import Cocoa

@IBDesignable

class BouncingBallsView: NSView {
    
    var balls: [Ball] = []
    
    var speed: CGFloat = 5.0
    
    convenience override init(frame frameRect: NSRect) {
       
        self.init()
   
        
    }
    
    func addBalls()
    {
        self.balls.append(Ball(center: CGPoint(x: 100,y: 100), radius: 50.0, color: NSColor.red))
        
        self.balls.append(Ball(center: CGPoint(x: 200,y: 200), radius:20.0, color: NSColor.green))
        
        self.balls.append(Ball(center: CGPoint(x: 500,y: 500), radius:30.0, color: NSColor.gray))
        
         self.balls.append(Ball(center: CGPoint(x: 100,y: 500), radius:10.0, color: NSColor.purple))
    }
    
    
   
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }

    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        
        let myColor:NSColor = NSColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        myColor.setFill()
        
        NSRectFill(bounds)
        
        
        for ball in self.balls
        {
            ball.draw()
        }
        
        
    }

    func setSpeed(speed: CGFloat)
    {
       
        if speed < 1.0
        {
            self.speed = 1.0
        }
        else if speed > 20.0
        {
            self.speed = 20.0
        }
        else
        {
            self.speed = speed
        }
    
    }
    func setSize(size: CGFloat)
    {
        for ball in self.balls
        {
            ball.setRadius(radius: size)
        }
        
    }
   func animateScene()
   {
    
        for ball in self.balls
        {
            var collideFlag = false
            for otherBall in self.balls
            {
                if otherBall !== ball && otherBall.collide(ball: ball) == true
                {
                    collideFlag = true
                }
                
            }
            ball.move(dx: speed, dy: speed * 2, contextRect: self.bounds, collideFlag: collideFlag)
            self.needsDisplay = true
        }
    
   }
}
