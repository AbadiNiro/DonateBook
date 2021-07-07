//
//  Item+CoreDataClass.swift
//  DonateBook
//
//  Created by admin on 07/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit
var id:Int16 = 0
@objc(Item)
public class Item: NSManagedObject {
    
    
    static func create( itemName: String, itemDescription:String, itemCategory:String, itemLocation:String, itemContact:String, imgUrl:String)->Item{
        
          let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let item = Item(context: context)
        item.itemNumber = id
        id = id+1
        item.itemName = itemName
        item.itemCategory = itemCategory
        item.itemContact = itemContact
        item.itemLocation = itemLocation
        item.itemDescription = itemDescription
        item.imgUrl = imgUrl
        return item
    }

}
