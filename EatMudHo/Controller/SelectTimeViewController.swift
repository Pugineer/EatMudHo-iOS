//
//  SelectTimeViewController.swift
//  EatMudHo
//
//  Created by Chris on 24/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import UIKit
import LNICoverFlowLayout
class SelectTimeViewController: UIViewController {
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var scrollView: UIScrollView!
    var pageDatasource: [TimeView] = []
    func geneatePage() {
        for item in 0...photoModelDatasource.count-1 {
            let photoModel = photoModelDatasource[item]
            let page: TimeView = Bundle.main.loadNibNamed("TimeView", owner: self, options: nil)?.first as! TimeView
            page.imageView.image = photoModel.image
            page.textLabel.text = photoModel.imageDescription
            pageDatasource.append(page)
        }
    }
    var photoModelDatasource = [
        PhotoModel(image: UIImage(named: "Breakfast")!, imageDescription: "breakfast"),
        PhotoModel(image: UIImage(named: "Lunch")!, imageDescription: "lunch"),
        PhotoModel(image: UIImage(named: "AfternoonTea")!, imageDescription: "afternoon tea"),
        PhotoModel(image: UIImage(named: "Dinner")!, imageDescription: "dinner"),
        PhotoModel(image: UIImage(named: "Supper")!, imageDescription: "supper")]
    
    func setupScrollView(pages: [TimeView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(pages.count), height: 200)
        scrollView.isPagingEnabled = true
        
        for page in 0...pages.count-1 {
            pages[page].frame = CGRect(x: view.frame.width * CGFloat(page), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(pages[page])
        }
    }
    var apiRequestHandler: APIRequestHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        geneatePage()
        scrollView.delegate = self
        view.bringSubviewToFront(pageControl)
        setupScrollView(pages: pageDatasource)
        pageControl.numberOfPages = pageDatasource.count
        pageControl.currentPage = 0
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

extension SelectTimeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
