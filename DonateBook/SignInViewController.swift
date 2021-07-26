//
//  SignInViewController.swift
//  DonateBook
//
//  Created by admin on 14/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class SignInViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginGuestButton: UIButton!
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // front
        
        signUpButton.layer.cornerRadius = 8
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.9)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white ]
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    @IBAction func didTapLogin(_ sender: Any) {
        
        FirebaseAuth.Auth.auth().signIn(withEmail: userName.text!, password: passWord.text!) { [weak self] authResult, error in
            
            //TODO alert window
            if error != nil {print ("login failed")}
            else {
                print("login succeeded")
                self?.performSegue(withIdentifier: "tapLogin", sender: self)
            }
        }
    }
    
    @IBAction func backToWelcome(segue : UIStoryboardSegue){
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
