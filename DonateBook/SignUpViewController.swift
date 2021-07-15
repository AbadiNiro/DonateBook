//
//  SignUpViewController.swift
//  DonateBook
//
//  Created by admin on 14/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {


    
    
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Pass: UITextField!
    @IBOutlet weak var Pass2: UITextField!
    
    @IBAction func didTapRegister(_ sender: Any) {
        FirebaseAuth.Auth.auth().createUser(withEmail: Email.text!, password: Pass.text!) { authResult, error in
            if let err = error{
               print("create failed")   }
            else{
               print("create success")
                
                            }
            
        }
         self.navigationController?.popViewController(animated: true)
        
        
    }
     

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     

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
