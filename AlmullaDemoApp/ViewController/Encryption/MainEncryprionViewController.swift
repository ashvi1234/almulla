//
//  MainEncryprionViewController.swift
//  AlmullaDemoApp
//
//  Created by Ashwini Apurkar on 07/10/20.
//  Copyright © 2020 Ashwini Apurkar. All rights reserved.
//

import UIKit
import RNCryptor

class MainEncryprionViewController: UIViewController {

    @IBOutlet weak var topView: comntopView!
    @IBOutlet weak var bottomView: comnbottomView!
    
    @IBOutlet weak var messageTf: UITextField!
    @IBOutlet weak var secrtKeyTf: UITextField!
    @IBOutlet weak var encryptdecrptStringLbl: UILabel!
    @IBOutlet weak var encryptBtn: UIButton!
    @IBOutlet weak var decryptBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        topView.currentVC = self
        bottomView.currentbottomVC = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        messageTf.text! = LocalizationProvider.Screen_Message
        secrtKeyTf.text! = LocalizationProvider.Screen_SecretKey
        encryptBtn.setTitle(LocalizationProvider.Screen_Encrypt, for: .normal)
        decryptBtn.setTitle(LocalizationProvider.Screen_Decrypt, for: .normal)
    }
    
    //MARK:- UIButtonCliked
    @IBAction func encryptBtnCliked(_ sender: Any)
    {
        do {
            try encryptMessage(message: messageTf.text!, encryptionKey: secrtKeyTf.text!)
        } catch{ }
    }
    
    @IBAction func decryptBtnCliked(_ sender: Any)
    {
       if(messageTf.text! != encryptdecrptStringLbl.text!){
          do {
            try decryptMessage(encryptedMessage: encryptdecrptStringLbl.text!, encryptionKey: secrtKeyTf.text!)
          } catch{ }
        }
    }
    
    //MARK:- Encryption/Deecryption
    func encryptMessage(message: String, encryptionKey: String) throws -> String {
        let messageData = message.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: messageData, withPassword: encryptionKey)
        print("cipherData=",cipherData)
        encryptdecrptStringLbl.text = cipherData.base64EncodedString()
        return cipherData.base64EncodedString()
    }

    func decryptMessage(encryptedMessage: String, encryptionKey: String) throws -> String {
        let encryptedData = Data.init(base64Encoded: encryptedMessage)!
        let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: encryptionKey)
        let decryptedString = String(data: decryptedData, encoding: .utf8)!
        encryptdecrptStringLbl.text = decryptedString
        return decryptedString
    }
    
    
}
