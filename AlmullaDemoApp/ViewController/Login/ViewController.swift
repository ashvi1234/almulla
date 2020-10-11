//
//  ViewController.swift
//  AlmullaDemoApp
//
//  Created by Ashwini Apurkar on 06/10/20.
//  Copyright © 2020 Ashwini Apurkar. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController,GIDSignInDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
  
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        var handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    //MARK:- buttonAction
    @IBAction func signInBtnCliked(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    //MARK:- GooglesignIn Delegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("Google Sing In didSignInForUser")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let calculator: ContainerViewController = storyBoard.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
        self.navigationController?.pushViewController(calculator, animated: true)
        
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication.idToken)!, accessToken: (authentication.accessToken)!)// When user is signed in
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                return
            }
        })
        
    }
    
}


