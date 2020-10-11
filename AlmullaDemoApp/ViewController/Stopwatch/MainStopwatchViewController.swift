//
//  MainStopwatchViewController.swift
//  AlmullaDemoApp
//
//  Created by Ashwini Apurkar on 07/10/20.
//  Copyright © 2020 Ashwini Apurkar. All rights reserved.
//

import UIKit

class MainStopwatchViewController: UIViewController {

    @IBOutlet weak var topView: comntopView!
    @IBOutlet weak var bottomView: comnbottomView!
    @IBOutlet weak var timerLbl: UILabel!
    
    @IBOutlet weak var pauseBtn: UIButton!
    var startTime = TimeInterval()
    var timer:Timer = Timer()
    var isTiming = Bool()
    var isPaused = Bool()
    var pausedTime: NSDate?   //track the time current pause started
    var pausedIntervals = [TimeInterval]()   //track previous pauses
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        topView.currentVC = self
        bottomView.currentbottomVC = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK:- ButtonCLiked
    @IBAction func stopBtnCliked(_ sender: Any)
    {
        timer.invalidate()
    }
    
    @IBAction func startBtnCliked(_ sender: Any)
    {
        if (!timer.isValid)
        {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate
        }
    }
    
    @IBAction func pauseBtnCliked(_ sender: Any)
    {
        timer.invalidate() //Stop the Timer
    }
    
    @objc func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate
        
        //Find the difference between current time and start time.
        var elapsedTime: TimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        timerLbl.text = "\(strMinutes):\(strSeconds):\(strFraction)"
    }
    

}
