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
import SwiftKeychainWrapper


class SignInVC: UIViewController {

    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
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
    
    @IBAction func signInTapped(_ sender: AnyObject) {
        
        if let email = emailField.text , let pwd = passwordField.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                
                if error == nil {
                    print("WOJTEK: EMAIL USER AUTHENTICATED WITH FIREBASE")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                    
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            
                        print("WOJTEK: UNABLE TO AUTHENTICATE WITH FIREBASE - \(error)")
                        } else {
                            
                            print("WOJTEK: SUCCESFULLY AUTHENTICATED WITH FIREBASE")
                            if let user = user {
                                self.completeSignIn(id: (user.uid))
                            }
                            
                        }
                    })
                }
            })
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            
            if error != nil {
                print("WOJTEK: UNABLE TO AUTHENTICATE WITH FIREBASE - \(error)")
            } else {
                print("WOJTEK: SUCCESFULLY AUTHENTICATED WITH FIREBASE")
                if let user = user {
                self.completeSignIn(id: user.uid)
                }
                
            }
        })
    }
    
    func completeSignIn(id: String) {
        
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("WOJTEK: DATA SAVED TO KEYCHAIN \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    

}

















