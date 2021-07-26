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

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var editingFlag = false
    var data = [Item]()
    var refreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // get all from viewWillAppear
        //front
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.9)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white ]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
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

            let uid = user.uid

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
                self.spinner.stopAnimating()
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
            print("move to add donation segue")
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

