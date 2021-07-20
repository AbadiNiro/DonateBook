
//
//  Model.swift
//  DonateBook
//
//  Created by admin on 07/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Model{
    static public let notificationItemList = "com.DonateBook.notificationItemList"
    static let instance = Model()
    let modelFirebase = ModelFirebase()
    
    private init(){}
    var items = [Item]()
    
    func getAllItems(callback:@escaping ([Item])->Void){
        modelFirebase.getAllItems(callback: callback)
    }
    
    func add(item:Item,callback: @escaping ()->Void){
        modelFirebase.add(item:item, callback:callback)
    }
    
    func delete(item:Item){
        modelFirebase.delete(item: item)
    }
    
}
