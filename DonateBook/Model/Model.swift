
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
   
    
    private init(){}
    var items = [Item]()
    
    func getAllItems(callback:@escaping ([Item])->Void){
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
