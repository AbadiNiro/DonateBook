
//
//  Model.swift
//  DonateBook
//
//  Created by admin on 07/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//

import Foundation

class Model{
    static let instance = Model()
    var items = [Item]()
    
    private init(){}
    
    func getAllItems()->[Item]{
        return items
        
    }
    
    func add(item:Item){
        items.append(item)
    }
    
    func delete(item:Item){
        var i = 0
        for it in items{
            if it.itemNumber == item.itemNumber{
                items.remove(at: i)
                return
            }
        i = i + 1
        }
    }
    
    
    
    
}
