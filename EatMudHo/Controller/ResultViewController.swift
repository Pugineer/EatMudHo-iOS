//
//  ResultViewController.swift
//  EatMudHo
//
//  Created by Chris on 24/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var restaurantTextLabel: UILabel!
    var apiRequestHandler: APIRequestHandler?
    var data: Array<SearchRestaurantModel>?
    override func viewDidLoad() {
        super.viewDidLoad()
        randomGeneration()
        // Do any additional setup after loading the view.
    }
    
    func randomGeneration() {
        if apiRequestHandler?.getMode() == "Single" {
            if let totalNum = data?.first!.response.venues.count {
                let randNum = Int.random(in: 0...totalNum-1)
                restaurantTextLabel.text = data?.first!.response.venues[randNum].name
            }
            else {
                print("0 Venue founded.")
            }
        }
        else if apiRequestHandler?.getMode() == "Multi" {
            // Type randoming
            var randNum = Int.random(in: 0...99)
            let type: Int
            if randNum < 50 {
                type = 0
            }
            else if randNum >= 50 && randNum < 84 {
                type = 1
            }
            else {
                type = 2
            }
            if let totalNum = data?[type].response.venues.count {
                randNum = Int.random(in: 0...totalNum-1)
                restaurantTextLabel.text = data?[type].response.venues[randNum].name
            }
            else {
                print("0 Venue founded")
            }
            
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
