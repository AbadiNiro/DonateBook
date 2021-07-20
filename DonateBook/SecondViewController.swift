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
    //var categoryForSearch = String()
    //var locationForSearch = String()
    var data = [Item]()
    var categorySearchResult = String()
    var locationSearchResult = String()
    
   
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        print(categorySearchResult + locationSearchResult)
        
        //asaf
        searchTableView.addSubview(refreshControl)
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
        //spiner?
        Model.instance.getAllItems { items in

            var filtered = [Item]()
                
            for item in items{
                
                if((self.categorySearchResult == "" || self.categorySearchResult == "None") && (self.locationSearchResult == "" || self.locationSearchResult == "None")){
                    filtered.append(item)
                }
                else if((self.categorySearchResult != "" || self.categorySearchResult != "None") && (self.locationSearchResult == "" || self.locationSearchResult == "None")){
                    if (self.categorySearchResult == item.itemCategory){
                        filtered.append(item)
                    }
                }
                else if((self.categorySearchResult == "" || self.categorySearchResult == "None")&&(self.locationSearchResult != "" || self.locationSearchResult != "None")){
                    if (self.locationSearchResult == item.itemLocation){
                        filtered.append(item)
                    }
                }
                else{
                    if (self.locationSearchResult == item.itemLocation && self.categorySearchResult == item.itemCategory){
                        filtered.append(item)
                    }
                }
            }
            self.data = filtered
            self.searchTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        //spiner?
    }
    
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            //let cell = searchTableView.dequeueReusableCell(withIdentifier: "searchListRow", for:indexPath) as! ItemTableViewCell
                
            // let item = data[indexPath.row]
            //cell.itemName.text = item.itemName
            // cell.itemCategory.text = item.itemCategory
            // cell.itemLocation.text = item.itemLocation
            // cell.itemDescription.text = item.itemDescription
            //  cell.itemContact.text = item.itemContact
            //cell.itemImg.image = item.imgUr
                
            //return cell
              return Item.itemCell(tableView,cellForRowAt: indexPath,identifier: "searchListRow",data:data)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // testing comment
    }

        

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
        Model.instance.getAllItems { items in
            
        
        var filtered = [Item]()
            
        for item in items{
            
            if((self.categorySearchResult == "" || self.categorySearchResult == "None") && (self.locationSearchResult == "" || self.locationSearchResult == "None")){
                filtered.append(item)
            }
            else if((self.categorySearchResult != "" || self.categorySearchResult != "None") && (self.locationSearchResult == "" || self.locationSearchResult == "None")){
                if (self.categorySearchResult == item.itemCategory){
                    filtered.append(item)
                }
            }
            else if((self.categorySearchResult == "" || self.categorySearchResult == "None")&&(self.locationSearchResult != "" || self.locationSearchResult != "None")){
                if (self.locationSearchResult == item.itemLocation){
                    filtered.append(item)
                }
            }
            else{
                if (self.locationSearchResult == item.itemLocation && self.categorySearchResult == item.itemCategory){
                    filtered.append(item)
                }
            }
                
            }
        self.data = filtered
        self.searchTableView.reloadData()
            }*/
            
        }
    
    
    
    
}




