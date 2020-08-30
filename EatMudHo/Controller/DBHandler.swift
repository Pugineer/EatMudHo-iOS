//
//  DBHandler.swift
//  EatMudHo
//
//  Created by Chris on 29/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import Foundation
import Firebase
struct DBHandler {
    var db = Firestore.firestore()
    var restaurantID: String?
    
    // MARK: - Get Set Methods
    mutating func setRestaurantID(with id: String) {
        restaurantID = id
    }
    
    // MARK: - Database handling methods
    func checkDB() -> DBModel? {
        let dbRef = db.collection(Constants.Database.collectionName)
        let query = dbRef.whereField("ID", isEqualTo: restaurantID!)
        var dbModel: DBModel?
        query.addSnapshotListener({ (quarySnapShot, error) in
            if let e = error {
                print(e)
            }
            else {
                if let snapshotDocuments = quarySnapShot?.documents {
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        let id = data[Constants.Database.idField] as? String
                        let name = data[Constants.Database.nameField] as? String
                        let address = data[Constants.Database.nameField] as? String
                        let categories = data[Constants.Database.categoriesField] as? String
                        let phone = data[Constants.Database.phoneField] as? String
                        let rating = data[Constants.Database.ratingField] as? Double
                        let time = data[Constants.Database.timeField] as? [String]
                        let days = data[Constants.Database.daysField] as? String
                        let newDBModel = DBModel(id: id, name: name, phone: phone, categories: categories, location: address, rating: rating, time: time, days: days)
                        dbModel = newDBModel
                    }
                }
            }
        })
        return dbModel
    }
    
    
    
    func fetchToDB(){
        let urlString = "https://api.foursquare.com/v2/venues/\(restaurantID!)?&client_id=TKN4AJFGMFBKMG05NERVAEPW44SBLXBE5XGQG2HCYATUJQKA&client_secret=G1KNKIJYWDYW1HTDU144KU3KJDCRUTAJ2ID0GILSFA2HBEFG&v=20200823"
        
        print(urlString)
        
        let data = performRequest(urlString: urlString)
        let id = data?.response.venue.id ?? ""
        let name = data?.response.venue.name ?? ""
        let address = data?.response.venue.location?.address ?? ""
        let categoriesName = data?.response.venue.categories[0].name ?? ""
        let phone = data?.response.venue.contact?.phone ?? ""
        let rating = data?.response.venue.rating ?? 0
        var time: Array<String> = []
        var days = ""
        
        if let hours = data?.response.venue.hours {
            if hours.timeframes[0].open?.count ?? 0 > 1 {
                let amTime = hours.timeframes[0].open?[0].renderedTime ?? ""
                let pmTime = hours.timeframes[0].open?[1].renderedTime ?? ""
                time.append(amTime)
                time.append(pmTime)
            }
            else {
                let dayTime = hours.timeframes[0].open?[0].renderedTime ?? ""
                time.append(dayTime)
            }
            days = hours.timeframes[0].days ?? ""
        }
        
        
        if name == "" {
            print("Name is not found in data.")
        }
        if address == "" {
            print("Address is not found in data.")
        }
        if categoriesName == "" {
            print("Categories name is not found in data.")
        }
        if phone == "" {
            print("Phone is not found in data.")
        }
        if rating == 0 {
            print("Rating is not found in data.")
        }
        if data?.response.venue.hours == nil {
            print("Hours is not found in data.")
        }
        
        let detail =
            [
                Constants.Database.idField: id,
                Constants.Database.nameField: name,
                Constants.Database.phoneField: phone,
                Constants.Database.categoriesField: categoriesName,
                Constants.Database.addressField: address,
                Constants.Database.ratingField: rating,
                Constants.Database.timeField: time,
                Constants.Database.daysField: days
                ] as [String : Any]
        
        db.collection(Constants.Database.collectionName).addDocument(data: detail)
    }
    
    func performRequest(urlString: String) -> RestaurantModel? {
        var resultData: RestaurantModel?
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
    
    func parseJson(data: Data) -> RestaurantModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RestaurantModel.self, from: data)
            return decodedData
        }
        catch {
            print(error)
            print("Data cannot be decoded")
            return nil
        }
    }
    
}
