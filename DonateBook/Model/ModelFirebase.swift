//
//  ModelFirebase.swift
//  DonateBook
//
//  Created by admin on 11/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//

import Foundation
import Firebase

class ModelFirebase{
    init(){
        //FirebaseApp.configure()
    }
    
    func getAllItems(callback:@escaping ([Item])->Void){
        let db = Firestore.firestore()
        db.collection("items").getDocuments{snapshot, error in
            if let err = error{
                print("Error reading document:\(err)")
            }else{
                if let snapshot = snapshot{
                    var items = [Item]()
                    for snap in snapshot.documents{
                        if let it = Item.create(json:snap.data()){
                            items.append(it)
                        }
                    }
                    callback(items)
                    return
                }
            }
            callback([Item]())
        }
    }
    
    func add(item:Item,callback: @escaping ()->Void ){
        let db = Firestore.firestore()
        db.collection("items").document(item.itemNumber!).setData(item.toJson()){
            err in
            if let err = err {
                print("Error writing document: \(err)")
            }else{
                print("Document successfully written!")
            }
            callback()
        }
    }
    
    func delete(item:Item, callback: @escaping ()->Void ){
        let db = Firestore.firestore()
        db.collection("items").document(item.itemNumber!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document removed")
            }
        }
        callback()
    }

}
