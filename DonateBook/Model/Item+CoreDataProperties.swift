//
//  Item+CoreDataProperties.swift
//  DonateBook
//
//  Created by admin on 07/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var itemLocation: String?
    @NSManaged public var itemDescription: String?
    @NSManaged public var itemNumber: Int16
    @NSManaged public var itemName: String?
    @NSManaged public var imgUrl: String?
    @NSManaged public var itemContact: String?
    @NSManaged public var itemCategory: String?

}
