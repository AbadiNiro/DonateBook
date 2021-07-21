//
//  Item+CoreDataProperties.swift
//  
//
//  Created by admin on 21/07/2021.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var imgUrl: String?
    @NSManaged public var itemCategory: String?
    @NSManaged public var itemContact: String?
    @NSManaged public var itemDescription: String?
    @NSManaged public var itemLocation: String?
    @NSManaged public var itemName: String?
    @NSManaged public var itemNumber: String?
    @NSManaged public var userUID: String?
    @NSManaged public var lastUpdated: Int64
    @NSManaged public var delFlag: Bool

}
