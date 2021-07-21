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
class SecondViewController:UIViewController{
    let initlocation = CLLocationCoordinate2D(latitude: 31.000, longitude: 34.000)
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let mark = Marker(title: "home", subtitle: "asafi", coordinate: initlocation)
        mapView.addAnnotation(mark)
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

        
    

         
          
          

