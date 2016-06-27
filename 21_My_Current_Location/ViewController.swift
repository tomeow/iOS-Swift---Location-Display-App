//
//  ViewController.swift
//  21_My_Current_Location
//
//  Created by Tomomi Tamura on 6/26/16.
//  Copyright © 2016 Tomomi Tamura. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager:CLLocationManager!

    @IBOutlet var longitude: UILabel!
    @IBOutlet var latitude: UILabel!
    @IBOutlet var course: UILabel!
    @IBOutlet var speed: UILabel!
    @IBOutlet var altitude: UILabel!
    @IBOutlet var myAddress: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    
    }
    
     func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        var userLocation: CLLocation = locations[0]
        
        
        self.longitude.text = "\(userLocation.coordinate.longitude)"
        self.latitude.text = "\(userLocation.coordinate.latitude)"
        self.course.text = "\(userLocation.course)"
        self.speed.text = "\(userLocation.speed)"
        self.altitude.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                
                print(error)
                
            } else {
                
                if let p = placemarks?[0] {
                    
                    var subThoroughfare:String = ""
                    
                    if (p.subThoroughfare != nil) {
                        
                        subThoroughfare = p.subThoroughfare!
                        
                    }
                    
                    self.myAddress.text = "\(subThoroughfare) \(p.thoroughfare!) \(p.locality!) \(p.administrativeArea!)  \(p.postalCode!) \(p.country!)"
                    
                }
                
                
            }
    

        
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

