//
//  SearchViewController.swift
//  DonateBook
//
//  Created by admin on 18/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//


import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var categoryText: UITextField!
    @IBOutlet weak var locationText: UITextField!
    
    
    var categories = ["None","Furniture","Kitchen","Outdoor","Cloth","Shoes","Electronics","Sport equipment","Art","Cosmetics"]
    
    var locations = ["None","North","Center","South","Jerusalem","Hasharon","East Bank"]
    
    var pickerViewCategories = UIPickerView()
    var pickerViewLocations = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerViewCategories.delegate = self
        pickerViewCategories.dataSource = self
        
        pickerViewLocations.delegate = self
        pickerViewLocations.dataSource = self
        
        
        categoryText.inputView = pickerViewCategories
        categoryText.textAlignment = .center
        
        locationText.inputView = pickerViewLocations
        locationText.textAlignment = .center
            
        
        pickerViewCategories.tag = 1
        pickerViewLocations.tag = 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "tapSearch"){
            let stbvc = segue.destination as! SearchTabBarViewController
            stbvc.categoryForSearch = categoryText.text!
            stbvc.locationForSearch = locationText.text!
        }
        
        
    }
   
}
extension SearchViewController:UIPickerViewDelegate , UIPickerViewDataSource{
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
            categoryText.text = categories[row]
            categoryText.resignFirstResponder()
        }
        else{
            locationText.text = locations[row]
            locationText.resignFirstResponder()
        }
        
        
    
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

