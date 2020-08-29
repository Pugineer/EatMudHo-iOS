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
    var resultData: Array<SearchRestaurantModel>?
    override func viewDidLoad() {
        super.viewDidLoad()
        apiRequestHandler?.delegate = self
        apiRequestHandler?.generateResult()
        // Do any additional setup after loading the view.
    }
    
    // Hide the Nav bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.loadingToResultSegue {
            let destVC = segue.destination as! ResultViewController
            guard let data = resultData else {
                fatalError()
            }
            destVC.apiRequestHandler = apiRequestHandler
            destVC.data = data
        }
    }
    
}

extension LoadingResultViewController: APIRequestHandlerDelegate {
    
    func didFinishGeneratingData(data: Array<SearchRestaurantModel>?) {
        resultData = data
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Constants.loadingToResultSegue, sender: self)
        }
        
    }
    
}
