
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
    static let instance = Model()
    let modelFirebase = ModelFirebase()
    
    private init(){}
    var items = [Item]()
    
    func getAllItems(callback:@escaping ([Item])->Void){
   
    }
    
    func add(item:Item){
        
    }
    
    func delete(item:Item){
         
        }
    
}
