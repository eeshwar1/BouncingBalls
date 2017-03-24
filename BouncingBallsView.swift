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
        
        /*
        self.balls.append(Ball(center: CGPoint(x: 100,y: 100), radius: 50.0, color: NSColor.red))
        
        self.balls.append(Ball(center: CGPoint(x: 200,y: 200), radius:20.0, color: NSColor.green))
        
        self.balls.append(Ball(center: CGPoint(x: 500,y: 500), radius:30.0, color: NSColor.gray))
        
         self.balls.append(Ball(center: CGPoint(x: 100,y: 500), radius:10.0, color: NSColor.purple)) */
        
        for _ in 0..<1
        {
            let _ = self.addBall()
        }
    }
    
    
    func addBall() -> Bool
    {
               
        var added = false
        
        var attemptNumber = 0
        
        while added == false && attemptNumber <= 10
        {
            
            let centerX = randomNumber(MIN: Int(self.frame.minX + 100), MAX: Int(self.frame.maxX - 100))
            let centerY = randomNumber(MIN: Int(self.frame.minY + 10), MAX: Int(self.frame.minY + 50))
            
            var ballFrameFixed = false
            
            var radiusValue = 0
            
            var attemptNumberRadius = 0
            
            while (ballFrameFixed == false && attemptNumberRadius <= 10)
            {
                radiusValue = randomNumber(MIN: 20, MAX: 30)
                
                let ballRect = NSRect(x: centerX - radiusValue, y: centerY - radiusValue, width: 2 * radiusValue, height: 2 * radiusValue)
                ballFrameFixed = self.frame.contains(ballRect)
                attemptNumberRadius = attemptNumberRadius + 1
            }
            
            if ballFrameFixed == false
            {
                return false
            }
            let colorIndex = randomNumber(MIN: 0, MAX: ColorNames.count)
            
            
            let ball = Ball(center: CGPoint(x: centerX, y: centerY), radius: CGFloat(radiusValue), color: ColorNames[colorIndex], id: balls.count + 1)
            
            
            var collideFlag = false
            
            if self.frame.contains(ball.path.bounds)
            {
                
                for otherBall in self.balls
                {
                    if otherBall !== ball && otherBall.collide(ball: ball) == true
                    {
                        collideFlag = true
                    }
                    
                }
                
                if collideFlag == false
                {
                    self.balls.append(ball)
                    added = true
                
                }
            }
            attemptNumber = attemptNumber + 1
            
        }
        
        return added
        
        
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
       
        if speed < 0.0
        {
            self.speed = 0.0
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
    
    func setDisplayID(displayID: Bool)
    {
        for ball in self.balls
        {
            ball.setDisplayID(displayID: displayID)
        }
    }
    func getBallCount() -> Int{
        
        return self.balls.count
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
