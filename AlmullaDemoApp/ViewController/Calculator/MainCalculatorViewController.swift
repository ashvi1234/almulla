//
//  MainCalculatorViewController.swift
//  AlmullaDemoApp
//
//  Created by Ashwini Apurkar on 06/10/20.
//  Copyright © 2020 Ashwini Apurkar. All rights reserved.
//

import UIKit
import GoogleSignIn
import SideMenu

class MainCalculatorViewController: UIViewController {
   
    @IBOutlet weak var topView: comntopView!
    @IBOutlet weak var bottomView: comnbottomView!
    //    var viwTop = comntopView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        topView.currentVC = self
        bottomView.currentbottomVC = self
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        topView.welcomeLbl.text = LocalizationProvider.Screen_Welcome
        bottomView.calenderLbl.text! = LocalizationProvider.Screen_calculator
        bottomView.encryptionLbl.text! = LocalizationProvider.Screen_encryption
        bottomView.todoLbl.text! = LocalizationProvider.Screen_todo
        bottomView.stopwatchLbl.text! = LocalizationProvider.Screen_stopwatch
    }

    
}

