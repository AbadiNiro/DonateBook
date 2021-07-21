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
    
    func getAllItems(since:Int64, callback:@escaping ([Item])->Void){
        let db = Firestore.firestore()
        db.collection("items")
            .whereField("lastUpdated", isGreaterThan: Timestamp(seconds: since, nanoseconds: 0)).getDocuments{snapshot, error in
            if let err = error{
                print("Error reading document:\(err)")
            }else{
                if let snapshot = snapshot{
                    var items = [Item]()
                    print ("FB returned \(snapshot.count)")
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
                print("Document successfully written/edited!")
            }
        }
        callback()
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
    
    static func saveImage(image:UIImage, callback:@escaping (String)->Void){
        
     let storageRef = Storage.storage().reference(forURL:
     "gs://donatebook-9ddfe.appspot.com/pictures")
        
     let data = image.jpegData(compressionQuality: 0.8)
     let imageRef = storageRef.child("imageName")
     let metadata = StorageMetadata()
     metadata.contentType = "image/jpeg"
     imageRef.putData(data!, metadata: metadata) { (metadata, error) in
        imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    callback("")
                    return
                }
                print("url: \(downloadURL)")
                callback(downloadURL.absoluteString)
            }
        }
     }
}
