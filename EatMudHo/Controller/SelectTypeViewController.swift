//
//  SelectTypeViewController.swift
//  EatMudHo
//
//  Created by Chris on 24/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import UIKit

class SelectTypeViewController: UIViewController {

    var apiRequestHandler: APIRequestHandler?
    var foodType: Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func jpBtnPressed(_ sender: UIButton) {
        foodType.append("Japanese Restaurant")
        apiRequestHandler?.setType(with: foodType)
        performSegue(withIdentifier: Constants.typeToLoadingSegue, sender: self)
    }
    @IBAction func generateBtnPressed(_ sender: UIButton) {
        
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! LoadingResultViewController
        destVC.apiRequestHandler = apiRequestHandler
        
    }
    

}
