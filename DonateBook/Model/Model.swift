
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
        modelFirebase.getAllItems(callback: callback)
    }
    
    func add(item:Item,callback: @escaping ()->Void){
        modelFirebase.add(item: item){
            callback()
            self.notificationItemList.post()
        }
    }
    
    
    func delete(item:Item,callback: @escaping ()->Void){
        modelFirebase.delete(item: item){
            self.notificationItemList.post()
        }
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
        
    
    
    
    
    
    
    
    

