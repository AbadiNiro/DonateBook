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
    var data = [Item]()
    
    
    
    
    
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
                return 158
            }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = ItemTableView.dequeueReusableCell(withIdentifier: "itemListRow") as! ItemTableViewCell
            
            let item = data[indexPath.row]
            cell.itemName.text = item.itemName
            cell.itemCategory.text = item.itemCategory
            cell.itemLocation.text = item.itemLocation
            cell.itemDescription.text = item.itemDescription
            cell.itemContact.text = item.itemContact
            //cell.itemImg.image = item.imgUrl
            
            return cell
        }
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                print("")
                
            }
            
    
            override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                Model.instance.getAllItems { items in
                    self.data = items
                    self.ItemTableView.reloadData()
                    
                }
            
            }
    
            func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
                editingFlag
            }
    
            func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let item = data[indexPath.row]
                Model.instance.delete(item: item)
                data.remove(at: indexPath.row)
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

