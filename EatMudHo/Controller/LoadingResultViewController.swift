//
//  LoadingResultViewController.swift
//  EatMudHo
//
//  Created by Chris on 24/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import UIKit

class LoadingResultViewController: UIViewController {

    var apiRequestHandler: APIRequestHandler?
    var restaurantData: SearchRestaurantModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        apiRequestHandler?.delegate = self
        apiRequestHandler?.performRequest()
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.loadingToResultSegue {
            let destVC = segue.destination as! ResultViewController
            guard let data = restaurantData else {
                fatalError()
            }
            destVC.data = data
        }
    }
    
}

extension LoadingResultViewController: APIRequestHandlerDelegate {
    func didFinishGeneratingData(data: SearchRestaurantModel) {
        restaurantData = data
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Constants.loadingToResultSegue, sender: self)
        }
    }
    
    
}
