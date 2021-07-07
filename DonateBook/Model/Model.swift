
//
//  Model.swift
//  DonateBook
//
//  Created by admin on 07/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//

import Foundation
import UIKit

class Model{
    static let instance = Model()
   
    
    private init(){}
    var items = [Item]()
    
    func getAllItems()->[Item]{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            let items = try context.fetch(Item.fetchRequest()) as! [Item]
            return items
            
        }catch{
            return [Item]()
        }
        
    }
    
    func add(item:Item){
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
        try context.save()
        }
        catch{}
    }
    
    func delete(item:Item){
           let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(item)
        do{
              try context.save()
              }
              catch{}
      
        }
    
    
    
    
    
}
