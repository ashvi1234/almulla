//
//  ChngeLangViewController.swift
//  AlmullaDemoApp
//
//  Created by Ashwini Apurkar on 06/10/20.
//  Copyright © 2020 Ashwini Apurkar. All rights reserved.
//

import UIKit

protocol changeLangDelegate: AnyObject
{
    func changeData(lang:String)
}

class ChngeLangViewController: UIViewController {

    weak var langDelegate: changeLangDelegate?
    
    @IBOutlet weak var engImg: UIImageView!
    @IBOutlet weak var arbicImg: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Change Language"
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back"), for: .normal) // Image can be downloaded from here below link
        backbutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }
    
    @objc func backAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnCliked(_ sender: Any) {
        langDelegate?.changeData(lang:Constant.selectedLanguageCode)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func englishBtnCliked(_ sender: Any) {
        engImg.image = UIImage(named: "circle-2")
        arbicImg.image = UIImage(named: "circle")
        Constant.selectedLanguageCode = "en"
    }
    
    @IBAction func arabicBtnCliked(_ sender: Any) {
        engImg.image = UIImage(named: "circle")
        arbicImg.image = UIImage(named: "circle-2")
        Constant.selectedLanguageCode = "ar"
    }
    

}
