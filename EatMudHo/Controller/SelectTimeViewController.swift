//
//  SelectTimeViewController.swift
//  EatMudHo
//
//  Created by Chris on 24/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import UIKit

class SelectTimeViewController: UIViewController {
    
    var apiRequestHandler: APIRequestHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBAction
    
    @IBAction func btnPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "Lunch" {
            let time = 1200
            apiRequestHandler?.setTime(with: time)
            performSegue(withIdentifier: Constants.timeToTypeSegue, sender: self)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.timeToTypeSegue {
            let destVC = segue.destination as! SelectTypeViewController
            destVC.apiRequestHandler = apiRequestHandler
            
        }
    }
    
    
}
