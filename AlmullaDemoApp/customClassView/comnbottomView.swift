//
//  comnbottomView.swift
//  AlmullaDemoApp
//
//  Created by Ashwini Apurkar on 07/10/20.
//  Copyright © 2020 Ashwini Apurkar. All rights reserved.
//

import UIKit
import SideMenu

class comnbottomView: UIView {

    @IBOutlet var bottomContainer: UIView!
    @IBOutlet weak var calenderBtn: UIButton!
    @IBOutlet weak var encyptnBtn: UIButton!
    @IBOutlet weak var todoBtn: UIButton!
    @IBOutlet weak var stopwatchBtn: UIButton!
    @IBOutlet weak var calenderLbl: UILabel!
    @IBOutlet weak var encryptionLbl: UILabel!
    @IBOutlet weak var todoLbl: UILabel!
    @IBOutlet weak var stopwatchLbl: UILabel!
    
    var currentbottomVC = UIViewController()
    var vc = UIViewController()
    
    //MARK:- Load xib
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.seccommonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.seccommonInit()
    }
    
    //MARK:- User defined functions
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    func seccommonInit() {
        // Load nib & add viwContent in main screen
        Bundle.main.loadNibNamed("comnbottomView", owner: self, options: nil)
        addSubview(bottomContainer)
        bottomContainer.frame = self.bounds
        bottomContainer.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        calenderLbl.text! = LocalizationProvider.Screen_calculator
        encryptionLbl.text! = LocalizationProvider.Screen_encryption
        todoLbl.text! = LocalizationProvider.Screen_todo
        stopwatchLbl.text! = LocalizationProvider.Screen_stopwatch
    }
   
   //MARK:- IBOultet
    @IBAction func calenderBtnCliked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let containerVC = storyBoard.instantiateViewController(withIdentifier: "MainCalculatorViewController") as! MainCalculatorViewController
        calenderBtn.setImage(UIImage(named: "planning"), for: .normal)
        encyptnBtn.setImage(UIImage(named: "encryption"), for: .normal)
        todoBtn.setImage(UIImage(named: "to-do"), for: .normal)
        stopwatchBtn.setImage(UIImage(named: "stopwatch"), for: .normal)
        currentbottomVC.slideMenuController()?.changeMainViewController(containerVC, close: true)
//        currentbottomVC.navigationController?.pushViewController(containerVC, animated: true)
    }
    
    @IBAction func encryptionBtnCliked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MainEncryprionViewController") as! MainEncryprionViewController
        calenderBtn.setImage(UIImage(named: "planning-2"), for: .normal)
        encyptnBtn.setImage(UIImage(named: "encryption-2"), for: .normal)
        todoBtn.setImage(UIImage(named: "to-do"), for: .normal)
        stopwatchBtn.setImage(UIImage(named: "stopwatch"), for: .normal)
        currentbottomVC.slideMenuController()?.changeMainViewController(vc, close: true)
    }
    
    @IBAction func todoBtnCliked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MainAddTaskViewController") as! MainAddTaskViewController
        calenderBtn.setImage(UIImage(named: "planning-2"), for: .normal)
        encyptnBtn.setImage(UIImage(named: "encryption"), for: .normal)
        todoBtn.setImage(UIImage(named: "to-do-2"), for: .normal)
        stopwatchBtn.setImage(UIImage(named: "stopwatch"), for: .normal)
        currentbottomVC.slideMenuController()?.changeMainViewController(vc, close: true)
    }
    
    @IBAction func stopwatchBtnCliked(_ sender: Any)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MainStopwatchViewController") as! MainStopwatchViewController
        calenderBtn.setImage(UIImage(named: "planning-2"), for: .normal)
        encyptnBtn.setImage(UIImage(named: "encryption"), for: .normal)
        todoBtn.setImage(UIImage(named: "to-do"), for: .normal)
        stopwatchBtn.setImage(UIImage(named: "stopwatch-2"), for: .normal)
        currentbottomVC.slideMenuController()?.changeMainViewController(vc, close: true)
    }
    
    
  
    
}
