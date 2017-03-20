//
//  ViewController.swift
//  BouncingBalls
//
//  Created by Venky Venkatakrishnan on 3/19/17.
//  Copyright © 2017 Venky Venkatakrishnan. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var timer = Timer()
    

    @IBOutlet var bouncingBallsView: BouncingBallsView!
    @IBOutlet var buttonStart: NSButton!
    
    @IBOutlet var buttonStop: NSButton!
    
    @IBOutlet var sliderSpeed: NSSlider!
    
    @IBOutlet var sliderSize: NSSlider!
    
    @IBOutlet var labelSpeed: NSTextField!
    
    @IBOutlet var labelSize: NSTextField!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.bouncingBallsView.setSpeed(speed:CGFloat(sliderSpeed.floatValue))
        
        self.bouncingBallsView.setSize(size: CGFloat(sliderSize.floatValue))
        
        self.bouncingBallsView.addBalls()
        
        labelSpeed.stringValue = String(format: "%.0f",sliderSpeed.floatValue)
        
        labelSize.stringValue = String(format: "%.0f",sliderSize.floatValue)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func clickStart(_ sender: Any) {
     
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(ViewController.animateScene), userInfo: nil, repeats: true)
        buttonStart.isEnabled = false
        buttonStop.isEnabled = true
        
    }
    
    @IBAction func clickStop(_ sender: Any) {
        
        timer.invalidate()
        buttonStop.isEnabled = false
        buttonStart.isEnabled = true
    }
    
    @IBAction func sliderSpeedChanged(_ sender: Any)
    {
        
        self.bouncingBallsView.setSpeed(speed: CGFloat(sliderSpeed.floatValue))
        
        labelSpeed.stringValue = String(format: "%.0f",sliderSpeed.floatValue)
    }
    
    @IBAction func sliderSizeChanged(_ sender: Any) {
        
        self.bouncingBallsView.setSize(size: CGFloat(sliderSize.floatValue))
        
        labelSize.stringValue = String(format: "%.0f",sliderSize.floatValue)
        
    }
    func animateScene()
    {
        DispatchQueue.main.async(
            
        execute: {
            
            // write code
            self.bouncingBallsView.animateScene()
            
        })
       
     
      
    }
}
