//
//  addDonateViewController.swift
//  DonateBook
//
//  Created by admin on 06/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//

import UIKit
//var id:Int16 = 0
class addDonateViewController: UIViewController {
    
    //@IBOutlet weak var itemImg: UIImageView!
    //@IBOutlet weak var itemName: UITextField!
    //@IBOutlet weak var itemCategory: UITextField!
    //@IBOutlet weak var itemDescription: UITextField!
    //@IBOutlet weak var itemLocation: UITextField!
    
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemLocation: UITextField!
    @IBOutlet weak var itemCategory: UITextField!
    @IBOutlet weak var itemDescription: UITextField!
    @IBOutlet weak var itemContact: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toAddDonateSegue"){
            print("dsas")
            
        }
    }
    
    @IBAction func backToMyDonations(segue: UIStoryboardSegue){
        print("Back to myDonation screen")
        
    }
    
   
    @IBAction func saveItem(_ sender: Any) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd-HH:mm:ss:ms"
        let timeStamp = format.string(from:date)
                
        var item = Item.create(itemNumber:timeStamp ,itemName: itemName.text!, itemDescription: itemDescription.text!, itemCategory: itemCategory.text!, itemLocation: itemLocation.text!, itemContact: itemContact.text!, imgUrl: "")
        
         //id = id+1
        //print(item.itemNumber)
                   
        //todo  image
        
//        item.itemNumber = id
//        id = id+1
//        item.itemName = itemName.text
//        item.itemDescription = itemDescription.text
//        item.itemCategory = itemCategory.text
//        item.itemLocation = itemLocation.text
//        item.itemContact = itemContact.text
          Model.instance.add(item: item ,callback: { self.navigationController?.popViewController(animated: true)})
          //print ("bla" + item.itemNumber!)
    
    }
    
 /*   @IBAction func save(_ sender: Any){
        let item = Item()
        
        // todo id???, image
        item.itemNumber = id
        id = id+1
        item.itemName = itemName.text
        item.itemDescription = itemDescription.text
        item.itemCategory = itemCategory.text
        item.itemLocation = itemLocation.text
        Model.instance.add(item: item)
        navigationController?.popViewController(animated: true)
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }
