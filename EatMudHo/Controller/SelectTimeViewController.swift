//
//  SelectTimeViewController.swift
//  EatMudHo
//
//  Created by Chris on 24/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import UIKit
import LNICoverFlowLayout
class SelectTimeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let sectionInsets = UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20)
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    var apiRequestHandler: APIRequestHandler?
    var photoModelDatasource = [
            PhotoModel(image: UIImage(named: Constants.Image.breakfastImage)!, imageDescription: "Breakfast"),
            PhotoModel(image: UIImage(named: Constants.Image.lunchImage)!, imageDescription: "Lunch"),
            PhotoModel(image: UIImage(named: Constants.Image.afternoonTeaImage)!, imageDescription: "Afternoon tea"),
            PhotoModel(image: UIImage(named: Constants.Image.dinnerImage)!, imageDescription: "Dinner"),
            PhotoModel(image: UIImage(named: Constants.Image.supperImage)!, imageDescription: "Supper"),
    ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(photoModelDatasource.count)
        return photoModelDatasource.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.timeCellReuseIdentifier, for: indexPath) as! timeCollectionViewCell
        let photoModel = photoModelDatasource[indexPath.row]
        print("index:" + String(indexPath.row))
        cell.imageView.image = photoModel.image
        cell.textLabel.text! = photoModel.imageDescription
        cell.imageView.layer.cornerRadius = 20
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
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
