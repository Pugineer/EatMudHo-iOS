//
//  SelectionViewController.swift
//  EatMudHo
//
//  Created by Chris on 23/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import UIKit
import CoreLocation
class SelectionViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: IBAction
    @IBAction func currentBtnPressed(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways {
            guard let currentLocation = locationManager.location else {
                return
            }
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            performSegue(withIdentifier: Constants.currentLocationToWhenSegue, sender: self)
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
