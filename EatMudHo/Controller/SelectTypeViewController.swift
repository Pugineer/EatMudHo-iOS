//
//  SelectTypeViewController.swift
//  EatMudHo
//
//  Created by Chris on 24/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import UIKit
import LNICoverFlowLayout
class SelectTypeViewController: UIViewController {
        
    var apiRequestHandler: APIRequestHandler?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        apiRequestHandler?.addStringToType(with: (sender.titleLabel?.text)!)
    }
    
    @IBAction func generateBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.typeToLoadingSegue, sender: self) 
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! LoadingResultViewController
        destVC.apiRequestHandler = apiRequestHandler
    }
    
    
}
