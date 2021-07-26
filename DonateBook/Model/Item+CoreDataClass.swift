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
import FirebaseAuth
import Kingfisher
import Firebase

@objc(Item)
public class Item: NSManagedObject {
    
    
    static func create(itemNumber:String ,  itemName: String, itemDescription:String, itemCategory:String, itemLocation:String, itemContact:String, imgUrl:String, lastUpdated:Int64 = 0, latitude:String, longitude:String)->Item{
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let item = Item(context: context)
        item.itemNumber = itemNumber
        item.itemName = itemName
        item.itemCategory = itemCategory
        item.itemContact = itemContact
        item.itemLocation = itemLocation
        item.itemDescription = itemDescription
        item.imgUrl = imgUrl
        item.lastUpdated = lastUpdated
        item.delFlag = false
        item.latitude = latitude
        item.longitude = longitude
        
        let user = Auth.auth().currentUser
        if let user = user {

          let uid = user.uid
          let email = user.email
          let photoURL = user.photoURL
          var multiFactorString = "MultiFactor: "
          for info in user.multiFactor.enrolledFactors {
            multiFactorString += info.displayName ?? "[DispayName]"
            multiFactorString += " "
          }
            item.userUID = user.uid
        }
        
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
        item.userUID = json["userUID"]as? String
        item.lastUpdated = 0
        if let timestamp = json["lastUpdated"] as? Timestamp{
            item.lastUpdated = timestamp.seconds
        }
        item.delFlag = false
        if let df = json["delFlag"] as? Bool{
            item.delFlag = df
        }
        item.latitude = json["latitude"]as? String
        item.longitude = json["longitude"]as? String
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
          json["lastUpdated"] = FieldValue.serverTimestamp()
          json["delFlag"] = delFlag
          json["latitude"] = latitude!
          json["longitude"] = longitude!
        
        let user = Auth.auth().currentUser
        if let user = user {

          let uid = user.uid
          let email = user.email
          let photoURL = user.photoURL
          var multiFactorString = "MultiFactor: "
          for info in user.multiFactor.enrolledFactors {
            multiFactorString += info.displayName ?? "[DispayName]"
            multiFactorString += " "
          }
            json["userUID"] = user.uid
        }
          return json
      }

}

extension Item{
   static func getAll(callback:@escaping ([Item])->Void){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = Item.fetchRequest() as NSFetchRequest<Item>
        request.predicate = NSPredicate(format: "delFlag != true")
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
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
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
    
    static func itemCell (_ tableView: UITableView, cellForRowAt indexPath: IndexPath, identifier:String, data:[Item])->UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! ItemTableViewCell
        let item = data[indexPath.row]
        cell.itemName.text = item.itemName
        cell.itemCategory.text = item.itemCategory
        cell.itemLocation.text = item.itemLocation
        cell.itemDescription.text = item.itemDescription
        cell.itemContact.text = item.itemContact
        //cell.itemImg.image = item.imgUrl
        let url = item.imgUrl
        
        // check
        let url1 = URL(string: String(url!))               
        cell.itemImg.kf.setImage(with:url1)

        return cell
        
    }
    static func setLocalLastUpdate(_ localLastUpdate:Int64){
        UserDefaults.standard.setValue( localLastUpdate, forKey: "ItemsLastUpdateDate")
    }
    
    static func getLocalLastUpdate()->Int64{
        Int64(UserDefaults.standard.integer(forKey: "ItemsLastUpdateDate"))
    }
    
}
