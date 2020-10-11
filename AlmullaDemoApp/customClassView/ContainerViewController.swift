//
//  ContainerViewController.swift
//  customHeaderViewDemo
//
//  Created by Ashwini Apurkar on 02/07/20.
//  Copyright © 2020 Ashwini Apurkar. All rights reserved.
//

import UIKit

class ContainerViewController: SlideMenuController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func awakeFromNib() {
        
        if let Homecontroller : MainCalculatorViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainCalculatorViewController") as? MainCalculatorViewController {
            self.mainViewController = Homecontroller
        }
        
        if let controller : LeftViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeftViewController") as? LeftViewController{
            self.leftViewController = controller
        }
        
        super.awakeFromNib()
        
    }
    
}
