//
//  ItemListViewController.swift
//  DonateBook
//
//  Created by admin on 06/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var ItemTableView: UITableView!

    var editingFlag = false
    var data = [1,2,3,4,5,6,7,8,9]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                return 115
            }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = ItemTableView.dequeueReusableCell(withIdentifier: "itemListRow") as! ItemTableViewCell
            cell.itemName.text = "item name"
            cell.itemCategory.text = "chair"
            cell.itemLocation.text = "north"
            cell.itemDescription.text = "new"
            
            return cell
        }
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                print("")
                
            }
            
            func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
                editingFlag
            }
    
            func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                data.remove(at: 0)
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

