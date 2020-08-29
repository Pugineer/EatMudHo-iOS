//
//  APIRequestHandler.swift
//  EatMudHo
//
//  Created by Chris on 24/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import Foundation

protocol APIRequestHandlerDelegate {
    func didFinishGeneratingData(data: Array<SearchRestaurantModel>?)
}
struct APIRequestHandler {
    var apiRequest = APIRequest()
    var delegate : APIRequestHandlerDelegate?
    // MARK: - Get Set Methods
    mutating func setLocation(with latitude: Double, _ longitude: Double) {
        apiRequest.latitude = latitude
        apiRequest.longitude = longitude
    }
    
    mutating func setTime(with time: Int) {
        apiRequest.time = time
    }
    
    mutating func addStringToType(with string: String) {
        let categoryID = translateStringToCategoryID(with: string)
        apiRequest.category?.append(categoryID)
    }
    
    mutating func setMode() {
        if apiRequest.category!.count == 1 {
            apiRequest.mode = "Single"
        }
        else if apiRequest.category!.count == 3 {
            apiRequest.mode = "Multi"
        }
    }
    
    func getMode() -> String? {
        return apiRequest.mode
    }
    
    // MARK: - API fetching
    func translateStringToCategoryID(with string: String) -> String {
        var categoryID = ""
        switch string {
        case "日本菜":
            categoryID = Constants.CategoryID.japaneseRestaurant
            break
        case "廣東菜":
            categoryID = Constants.CategoryID.cantoneseRestaurant
            break
        case "亞洲菜":
            categoryID = Constants.CategoryID.asianRestaurant
            break
        default:
            break
        }
        return categoryID
    }
    
    func createURLString(categoryID: String?, limit: Int, radius: Int) -> String {
        guard let latitude = apiRequest.latitude else {
            fatalError("Latitude is nil.")
        }
        guard let longitude = apiRequest.longitude else {
            fatalError("Longitude is nil.")
        }
        guard let categoryID = categoryID else {
            fatalError("CategoryID is nil.")
        }
        let urlString = "https://api.foursquare.com/v2/venues/search?&client_id=TKN4AJFGMFBKMG05NERVAEPW44SBLXBE5XGQG2HCYATUJQKA&client_secret=G1KNKIJYWDYW1HTDU144KU3KJDCRUTAJ2ID0GILSFA2HBEFG&ll=\(latitude),\(longitude)&categoryId=\(categoryID)&v=20200823&limit=\(limit)&radius=\(radius)"
        return urlString
    }
    
    func performRequest(urlString: String) -> SearchRestaurantModel? {
        var resultData: SearchRestaurantModel?
        if let url = URL(string: urlString) {
            let sem = DispatchSemaphore.init(value: 0)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: url) { (data, response, error) in defer {sem.signal()}
                if error != nil {
                    fatalError("fetching data error.")
                }
                if let safeData = data {
                    resultData = self.parseJson(data: safeData)
                }
            }
            task.resume()
            sem.wait()
            return resultData
        }
        else {
            return nil
        }
    }
    
    func generateResult() {
        DispatchQueue.global(qos: .background).async {
            var resultArray: Array<SearchRestaurantModel> = []
            if self.apiRequest.mode == "Single" {
                let urlString = self.createURLString(categoryID: self.apiRequest.category?.first, limit: 50, radius: 2500)
                let result = self.performRequest(urlString: urlString)
                resultArray.append(result!)
                self.delegate?.didFinishGeneratingData(data: resultArray)
            }
            else if self.apiRequest.mode == "Multi" {
                for item in 0...2 {
                    let urlString = self.createURLString(categoryID: self.apiRequest.category?[item], limit: 50, radius: 2500)
                    let result = self.performRequest(urlString: urlString)
                    resultArray.append(result!)
                }
                self.delegate?.didFinishGeneratingData(data: resultArray)
            }
            
        }
    }
    
    func parseJson(data: Data) -> SearchRestaurantModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(SearchRestaurantModel.self, from: data)
            return decodedData
        }
        catch {
            print(error)
            print("Data cannot be decoded")
            return nil
        }
    }
    
    
}
