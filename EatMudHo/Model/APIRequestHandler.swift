//
//  APIRequestHandler.swift
//  EatMudHo
//
//  Created by Chris on 24/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import Foundation

protocol APIRequestHandlerDelegate {
    func didFinishGeneratingData(data: SearchRestaurantModel)
}
struct APIRequestHandler {
    var apiRequest = APIRequest()
    var delegate : APIRequestHandlerDelegate?
    
    mutating func setLocation(with latitude: Double, _ longitude: Double) {
        apiRequest.latitude = latitude
        apiRequest.longitude = longitude
    }
    
    mutating func setTime(with time: Int) {
        apiRequest.time = time
    }
    
    mutating func setType(with type: Array<String>) {
        apiRequest.type = type
    }
    
    func typeToCategoryID(with type: String) -> String{
        var typeString = ""
        switch type {
        case "Japanese Restaurant":
            typeString = "4bf58dd8d48988d111941735"
            break
        default:
            break
        }
        return typeString
    }
    
    func handlingURLString() -> String {
        guard let latitude = apiRequest.latitude else {
            fatalError("Latitude is nil.")
        }
        guard let longitude = apiRequest.longitude else {
            fatalError("Longitude is nil.")
        }
        let time = apiRequest.time
        let type = apiRequest.type
        var typeString = ""
        if type?.count == 1 {
            typeString = typeToCategoryID(with: (type?.first)!)
        }
        else {
            
        }
        let llString = "\(latitude),\(longitude)"
        let limitString = 50
        let radius = 2500
        var urlString = "https://api.foursquare.com/v2/venues/search?&client_id=TKN4AJFGMFBKMG05NERVAEPW44SBLXBE5XGQG2HCYATUJQKA&client_secret=G1KNKIJYWDYW1HTDU144KU3KJDCRUTAJ2ID0GILSFA2HBEFG&ll=\(llString)&categoryId=\(typeString)&v=20200823&limit=\(limitString)&radius=\(radius)"
        return urlString
    }
    
    func performRequest() {
        let urlString = handlingURLString()
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    fatalError("fetching data error.")
                }
                
                if let safeData = data {
                    if let restaurantData = self.parseJson(data: safeData) {
                        self.delegate?.didFinishRetrievingData(data: restaurantData)
                    }
            
                }
            }
            task.resume()
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
