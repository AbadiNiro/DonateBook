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

    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        
        FirebaseAuth.Auth.auth().signIn(withEmail: userName.text!, password: passWord.text!) { [weak self] authResult, error in
            
        /*  guard let strongSelf = self else {
            
               return     }
          // ...
            guard error == nil else {print("a")
                return}
            
             print ("right customer")
            
        }*/
            if error != nil {print ("login failed")}
            else {
                print("login succeeded")
                let registeredZone = self?.storyboard?.instantiateViewController(withIdentifier:"registerZone")
                
                self?.view.window?.rootViewController = registeredZone
                self?.view.window?.makeKeyAndVisible()
            }
            
            
        }
        
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
