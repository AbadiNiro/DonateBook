//
//  Item+CoreDataClass.swift
//  
//
//  Created by admin on 13/07/2021.
//
//

import Foundation
import CoreData
import UIKit

@objc(Item)
public class Item: NSManagedObject {
    
    
    static func create(itemNumber:String ,  itemName: String, itemDescription:String, itemCategory:String, itemLocation:String, itemContact:String, imgUrl:String)->Item{
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let item = Item(context: context)
        item.itemNumber = itemNumber
        item.itemName = itemName
        item.itemCategory = itemCategory
        item.itemContact = itemContact
        item.itemLocation = itemLocation
        item.itemDescription = itemDescription
        item.imgUrl = imgUrl
        return item
    }
    static func create(json:[String:Any])->Item?{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
      
        let item = Item(context: context)
        item.itemNumber = json["itemNumber"] as? String
        item.itemName = json["itemName"]as? String
        item.itemCategory = json["itemCategory"]as? String
        item.itemContact = json["itemContact"]as? String
        item.itemLocation = json["itemLocation"]as? String
        item.itemDescription = json["itemDescription"]as? String
        item.imgUrl = json["imgUrl"]as? String
        
        return item
    }
    
    
    func toJson()->[String:Any]{
          var json = [String:Any]()
          json["itemNumber"] = itemNumber!
          json["itemName"] = itemName!
          json["itemCategory"] = itemCategory!
          json["itemContact"] = itemContact!
          json["itemLocation"] = itemLocation!
          json["itemDescription"] = itemDescription!
          if let imgUrl = imgUrl {
              json["imgUrl"] = imgUrl
          }else{
              json["imgUrl"] = " "
          }
          return json
      }

}

extension Item{
   static func getAll(callback:@escaping ([Item])->Void){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = Item.fetchRequest() as NSFetchRequest<Item>
        DispatchQueue.global().async {
            var data = [Item]()
            do{
                data = try context.fetch(request)
           }catch{
               
           }
        DispatchQueue.main.async{
                callback(data)
                
            }
        }
        
    }
    
    func save(){
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
        try context.save()
        }
        catch{}
    }
    
    func delete(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(self)
        do{
              try context.save()
              }
              catch{}

        }
    
}

