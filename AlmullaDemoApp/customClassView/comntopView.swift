//
//  comntopView.swift
//  AlmullaDemoApp
//
//  Created by Ashwini Apurkar on 07/10/20.
//  Copyright © 2020 Ashwini Apurkar. All rights reserved.
//

import UIKit
import SideMenu

class comntopView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var welcomeLbl: UILabel!
    var currentVC = UIViewController()
    
    //MARK:- Load xib
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    //MARK:- User defined functions
    func commonInit() {
        Bundle.main.loadNibNamed("comntopView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        welcomeLbl.text! = LocalizationProvider.Screen_Welcome
        
    }
    
    //MARK:- Button Clicks
    @IBAction func sideMenuBtnCliked(_ sender: Any)
    {
//        SlideMenuController().toggleLeft()
        currentVC.openLeft()
    }

    

}
