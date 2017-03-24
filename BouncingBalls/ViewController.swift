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
    

    
    @IBOutlet var tableView: NSTableView!
    
    @IBOutlet var bouncingBallsView: BouncingBallsView!
   
    
    @IBOutlet var buttonStartStop: NSButton!
    
    @IBOutlet var sliderSpeed: NSSlider!
    
    @IBOutlet var sliderSize: NSSlider!
    
    @IBOutlet var labelSpeed: NSTextField!
    
    @IBOutlet var labelSize: NSTextField!
    
    @IBOutlet var labelBallCount: NSTextField!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.bouncingBallsView.setSpeed(speed:CGFloat(sliderSpeed.floatValue))
        
        self.bouncingBallsView.setSize(size: CGFloat(sliderSize.floatValue))
        
        self.bouncingBallsView.addBalls()
        
        labelSpeed.stringValue = String(format: "%.0f",sliderSpeed.floatValue)
        
        labelSize.stringValue = String(format: "%.0f",sliderSize.floatValue)
        
        labelBallCount.stringValue = String(self.bouncingBallsView.balls.count)
        
        self.startTimer()
        self.buttonStartStop.title = "Stop"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func clickStartStop(_ sender: Any) {
        
        if buttonStartStop.title == "Start"
        {
            
            self.startTimer()
            buttonStartStop.title = "Stop"
        }
        else
        {
            self.stopTimer()
            buttonStartStop.title = "Start"
            
        }
        
    }
    func startTimer()
    {
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.animateScene), userInfo: nil, repeats: true)
        
    }
    
    func stopTimer()
    {
        
        timer.invalidate()
    }

    
    @IBAction func clickAddBall(_ sender: Any) {
        
        let _ = self.bouncingBallsView.addBall()
        
        labelBallCount.stringValue = String(self.bouncingBallsView.balls.count)
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
        
        self.bouncingBallsView.animateScene()
        self.tableView.reloadData()
     
      
    }
}

extension ViewController: NSTableViewDataSource
{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.bouncingBallsView.getBallCount()
    }
    
}

extension ViewController: NSTableViewDelegate
{
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    
        
        var text: String = ""
        var cellIdentifier: String = ""
        
        let ball = self.bouncingBallsView.balls[row]
        
       if tableColumn == tableView.tableColumns[0]
       {
        text = "(\(String(format: "%.0f",ball.center.x)),\((String(format: "%.0f",ball.center.y))))"
            cellIdentifier = "ballCenter"
        
        }
        if tableColumn == tableView.tableColumns[1]
        {
            text = String(describing: ball.radius)
            cellIdentifier = "ballRadius"
            
        }
      
        
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView
        {
            cell.textField?.stringValue = text
            return cell
        }
        else
        {
            print("Column: \(tableColumn), ERROR making cell")
            return nil
        }
    }
    
}

