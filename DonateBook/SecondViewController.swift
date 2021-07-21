//
//  SecondViewController.swift
//  DonateBook
//
//  Created by admin on 06/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class SecondViewController:UIViewController, MKMapViewDelegate{
 
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
  
        
        
        
        Model.instance.getAllItems { items in

                
            for item in items{
                if (item.latitude != "" ){
                    let longDouble = Double(item.longitude!)
                    let latDouble = Double(item.latitude!)
                    let currentLocation = CLLocationCoordinate2D(latitude: latDouble!, longitude: longDouble!)
                    let mark  = Marker(title: item.itemName!, subtitle: item.itemDescription!, coordinate: currentLocation)
                    self.mapView.addAnnotation(mark)
                   // mapView.delegate = self
                    
                }
                
            }
        }
        
           
    }

    
        
}

class Marker: NSObject, MKAnnotation {
  let title: String?
  let subtitle: String?
  let coordinate: CLLocationCoordinate2D
    
    
  init(
    title: String?,
    subtitle: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate

    super.init()
  }




}

        
    

         
          
          

