//
//  SearchTabBarViewController.swift
//  DonateBook
//
//  Created by admin on 18/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//

import UIKit

class SearchTabBarViewController: UITabBarController {
    
    var categoryForSearch = String()
    var locationForSearch = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = self.viewControllers![1] as! SecondViewController
        vc.categorySearchResult = categoryForSearch
        vc.locationSearchResult = locationForSearch
        print(categoryForSearch)
        // Do any additional setup after loading the view.
    }
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = self.viewControllers![1] as! SecondViewController
        vc.categorySearchResult = categoryForSearch
        vc.locationSearchResult = locationForSearch
        }*/
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}