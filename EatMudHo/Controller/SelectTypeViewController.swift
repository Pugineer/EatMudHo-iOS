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
    

    @IBAction func btnPressed(_ sender: UIButton) {
        apiRequestHandler?.addStringToType(with: (sender.titleLabel?.text)!)
    }
    
    @IBAction func generateBtnPressed(_ sender: UIButton) {
        apiRequestHandler?.setMode()
        performSegue(withIdentifier: Constants.typeToLoadingSegue, sender: self) 
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! LoadingResultViewController
        destVC.apiRequestHandler = apiRequestHandler
        
    }
    

}
