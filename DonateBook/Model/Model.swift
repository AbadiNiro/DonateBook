
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
    
    let notificationItemList = NotificationGeneralList(name : "itemNotification")
    
    private init(){}
    var items = [Item]()
    
    func getAllItems(callback:@escaping ([Item])->Void){
        // get the local update date
        var localLastUpdate = Item.getLocalLastUpdate()
        
        //get updates from FB
        modelFirebase.getAllItems(since:localLastUpdate){(items) in
           
            //update the local update date
            for it in items{
                print("item lastUP = \(it.lastUpdated)")
                
                if(it.lastUpdated > localLastUpdate){
                    localLastUpdate = it.lastUpdated
                }
                /*
                if(!it.delFlag){
                    if(it.lastUpdated > localLastUpdate){
                        localLastUpdate = it.lastUpdated
                    }
                }*/
            }
            
          
            Item.setLocalLastUpdate(localLastUpdate)
            
            //remove deleted
            for it in items{
                if it.delFlag{
                    it.delete()
                }
            }
            
            //update the local DB
            if (items.count > 0 ){
                items[0].save()
            }
            
            //read all students from local DB
            //return the list to the caller
            Item.getAll(callback: callback)
            
        }
    }

    func add(item:Item,callback: @escaping ()->Void){
        modelFirebase.add(item: item){
            callback()
            self.notificationItemList.post()
        }
    }
    
    
    func delete(item:Item,callback: @escaping ()->Void){
        item.delFlag = true
        modelFirebase.add(item: item,callback: callback)
    }
    
    func saveImage(image:UIImage,callback:@escaping (String)->Void){
        ModelFirebase.saveImage(image: image, callback: callback)
    }
    
    
}

class NotificationGeneralList{
    let name:String
    
    init(name:String) {
        self.name = name
    }
    

    
    func post (){
        NotificationCenter.default.post(name: NSNotification.Name(self.name), object: self)
    }
    
    func observe( callback: @escaping ()->Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(self.name), object: nil, queue: nil){
            (notification) in
            callback()
        }
    }
}
        
    
    
    
    
    
    
    
    

