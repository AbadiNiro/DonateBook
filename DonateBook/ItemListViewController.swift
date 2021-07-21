//
//  ItemListViewController.swift
//  DonateBook
//
//  Created by admin on 06/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//

import UIKit
import FirebaseAuth

class ItemListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var ItemTableView: UITableView!

    var editingFlag = false
    var data = [Item]()
    var refreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // get all from viewWillAppear
        ItemTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action:#selector(refresh), for: .valueChanged)
        reloadData()
        Model.instance.notificationItemList.observe {
            self.reloadData()
        }
    }
    
    @objc func refresh (_ sender : AnyObject){
        self.reloadData()
    }
    
    func reloadData(){
        //spiner
        refreshControl.beginRefreshing()
        Model.instance.getAllItems { items in
            let user = Auth.auth().currentUser
            if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            let uid = user.uid
            //let email = user.email
            //let photoURL = user.photoURL
            var multiFactorString = "MultiFactor: "
            for info in user.multiFactor.enrolledFactors {
                multiFactorString += info.displayName ?? "[DispayName]"
                multiFactorString += " "
            }
            var filtered = [Item]()
            for item in items{
                if(user.uid == item.userUID){
                    filtered.append(item)
                }
            }
            self.data = filtered
            self.ItemTableView.reloadData()
            self.refreshControl.endRefreshing()
            
            }
        }
        //spiner
    }
    
    @IBAction func editButton(_ sender: Any) {
        editingFlag = !editingFlag
        ItemTableView.setEditing(editingFlag, animated: true)
        }
    
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "toAddDonateSegue"){
                print("dsas")
            }
        }
        @IBAction func backToMyDonations(segue: UIStoryboardSegue){
            print("Back to myDonation screen")
        }
    
        //UITableViewDelegate
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }
            
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 158
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return Item.itemCell(tableView,cellForRowAt: indexPath,identifier: "itemListRow",data:data)
        }
    
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        }
        
            
    
            override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                // comment?
                /*
                Model.instance.getAllItems { items in
                    
                    let user = Auth.auth().currentUser
                    if let user = user {
                      // The user's ID, unique to the Firebase project.
                      // Do NOT use this value to authenticate with your backend server,
                      // if you have one. Use getTokenWithCompletion:completion: instead.
                      let uid = user.uid
                    //let email = user.email
                    //let photoURL = user.photoURL
                      var multiFactorString = "MultiFactor: "
                      for info in user.multiFactor.enrolledFactors {
                        multiFactorString += info.displayName ?? "[DispayName]"
                        multiFactorString += " "
                      }
                    
                    
                    
                    
                    var filtered = [Item]()
                    for item in items{
                        if(user.uid == item.userUID){
                            filtered.append(item)
                        }
                    }
                    self.data = filtered
                    self.ItemTableView.reloadData()
                    
                }
                }
                */
            }
    
            func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
                editingFlag
            }
    
            func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let item = data[indexPath.row]
                Model.instance.delete(item: item){
                    //Verify delete in FB
                    self.data.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }//!!!
               
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
    
    @IBAction func didTapSignOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        print("signout succeeded")
        self.performSegue(withIdentifier: "tapSignOut", sender: self)
        
        
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
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

