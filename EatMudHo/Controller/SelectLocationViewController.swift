//
//  SelectionViewController.swift
//  EatMudHo
//
//  Created by Chris on 23/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import UIKit
import CoreLocation
class SelectLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        // Do any additional setup after loadin g the view.
    }
    
    // MARK: IBAction
    @IBAction func currentBtnPressed(_ sender: UIButton) {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways {
            guard let currentLocation = locationManager.location else {
                return
            }
            locationManager.stopUpdatingLocation()
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            performSegue(withIdentifier: Constants.currentLocationToWhenSegue, sender: self)
        }
        else if CLLocationManager.authorizationStatus() == .denied {
            print("Denined")
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
    
}
