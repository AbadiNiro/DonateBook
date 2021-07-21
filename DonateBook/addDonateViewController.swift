//
//  addDonateViewController.swift
//  DonateBook
//
//  Created by admin on 06/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//
import CoreLocation
import UIKit
//var id:Int16 = 0
class addDonateViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate , CLLocationManagerDelegate{
    
    //@IBOutlet weak var itemImg: UIImageView!
    //@IBOutlet weak var itemName: UITextField!
    //@IBOutlet weak var itemCategory: UITextField!
    //@IBOutlet weak var itemDescription: UITextField!
    //@IBOutlet weak var itemLocation: UITextField!
    
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemLocation: UITextField!
    @IBOutlet weak var itemCategory: UITextField!
    @IBOutlet weak var itemDescription: UITextField!
    @IBOutlet weak var itemContact: UITextField!
    
    @IBOutlet weak var useLocation: UISwitch!
    
    var manager : CLLocationManager = CLLocationManager()
    
    
    var latitude:String = ""
    var longitude:String = ""
    
    var pickerViewCategories = UIPickerView()
    var pickerViewLocations = UIPickerView()
    
    var categories = ["Furniture","Kitchen","Outdoor","Cloth","Shoes","Electronics","Sport equipment","Art","Cosmetics"]
    
    var locations = ["North","Center","South","Jerusalem","Hasharon","East Bank"]
    
    var image : UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewCategories.delegate = self
        pickerViewCategories.dataSource = self
        pickerViewLocations.delegate = self
        pickerViewLocations.dataSource = self
        
        
        itemCategory.inputView = pickerViewCategories
        itemLocation.inputView = pickerViewLocations
            
        
        pickerViewCategories.tag = 1
        pickerViewLocations.tag = 2
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toAddDonateSegue"){
            print("dsas")
            
        }
    }
    
    @IBAction func backToMyDonations(segue: UIStoryboardSegue){
        print("Back to myDonation screen")
        
    }
    
    @IBAction func saveItem(_ sender: Any) {
        if let image = image{
            Model.instance.saveImage(image: image){ (url) in
                self.createItem(url: url)
            }
        }else{
                self.createItem(url: "")
            }
        }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func createItem (url:String){
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd-HH:mm:ss:ms"
        let timeStamp = format.string(from:date)
        
        if(!useLocation.isOn){
            //get current location
            longitude = ""
            latitude = ""
        }
        let item = Item.create(itemNumber:timeStamp ,itemName: itemName.text!, itemDescription: itemDescription.text!, itemCategory: itemCategory.text!, itemLocation: itemLocation.text!, itemContact: itemContact.text!, imgUrl: url,latitude: latitude, longitude: longitude)
        
          Model.instance.add(item: item){ self.navigationController?.popViewController(animated: true)}
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        guard let first = locations.first else {
            return
        }
        
        latitude = String(first.coordinate.latitude)
        longitude = String(first.coordinate.longitude)
        print ("lan and lon" + longitude + " " + latitude)
    }
   
    
    @IBAction func addImg(_ sender: Any) {
        if   UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
             let imgPicker = UIImagePickerController()
             imgPicker.delegate = self
             imgPicker.sourceType = UIImagePickerController.SourceType.camera
             imgPicker.allowsEditing = true
             self.present(imgPicker, animated: true, completion: nil)}
        else{
             let imgPicker = UIImagePickerController()
             imgPicker.delegate = self
             imgPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
             imgPicker.allowsEditing = true
             self.present(imgPicker, animated: true, completion: nil)
            }
    }
    
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.itemImg.image = image
        self.dismiss(animated: true, completion: nil)
    }

}

extension addDonateViewController:UIPickerViewDelegate , UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return categories.count
        }
        else{
            return locations.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return categories[row]
        }
        else{
            return locations[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 1){
            itemCategory.text = categories[row]
            itemCategory.resignFirstResponder()
        }
        else{
            itemLocation.text = locations[row]
            itemLocation.resignFirstResponder()
        }
        
        
    
    }
    
    
        
        
        
        
}
