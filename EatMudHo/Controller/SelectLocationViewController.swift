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
    var apiRequestHandler = APIRequestHandler()
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
            let latitude = currentLocation.coordinate.latitude
            let longitude = currentLocation.coordinate.longitude
            apiRequestHandler.setLocation(with: latitude, longitude)
            performSegue(withIdentifier: Constants.locToTimeSegue, sender: self)
            
            
        }
        else if CLLocationManager.authorizationStatus() == .denied {
            print("Denined")
        }
    }
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.locToTimeSegue {
            let destVC = segue.destination as! SelectTimeViewController
            destVC.apiRequestHandler = apiRequestHandler
            
        }
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
    
}
