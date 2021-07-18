//
//  SecondViewController.swift
//  DonateBook
//
//  Created by admin on 06/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    
    @IBOutlet weak var searchTableView: UITableView!
    
    var data = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "searchListRow", for:indexPath) as! ItemTableViewCell
        
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
    
        }

        

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Model.instance.getAllItems { items in
            self.data = items
            self.searchTableView.reloadData()
            }
            
        }
    
    
    
    
    }




