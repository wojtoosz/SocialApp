//
//  SignInVC.swift
//  SocialApp
//
//  Created by Wojciech Charuza on 10.11.2016.
//  Copyright © 2016 Wojciech Charuza. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }



    @IBAction func facebookBtnTapped(_ sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("WOJTEK: UNABLE TO AUTHENTICATE WITH FACEBOOK - \(error)")
            } else if result?.isCancelled == true {
                print("WOJTEK: USER CANCELLED AUTHENTICATION")
            } else {
                
                print("WOJTEK: SUCCESFULLY AUTHENTICATED WITH FACEBOOK")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            
            if error != nil {
                print("WOJTEK: UNABLE TO AUTHENTICATE WITH FIREBASE - \(error)")
            } else {
                print("WOJTEK: SUCCESFULLY AUTHENTICATED WITH FIREBASE")
            }
        })
    }

}

