//
//  Constants.swift
//  EatMudHo
//
//  Created by Chris on 23/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import Foundation

struct Constants {
    static let regionTableCellReuseIdentifier = "regionTableCell"
    static let regionTableCellNib = "RegionTableViewCell"
    static let locToTimeSegue = "LocToTime"
    static let timeToTypeSegue = "TimeToType"
    static let typeToLoadingSegue = "TypeToLoading"
    static let loadingToResultSegue = "LoadingToResult"
    static let timeCellReuseIdentifier = "timeCell"
    
    struct Image {
        static let breakfastImage = "Breakfast"
        static let lunchImage = "Lunch"
        static let afternoonTeaImage = "AfternoonTea"
        static let dinnerImage = "Dinner"
        static let supperImage = "Supper"
    }
    // MARK: - Restaurant Category ID
    struct CategoryID {
        static let japaneseRestaurant = "4bf58dd8d48988d111941735"
        static let cantoneseRestaurant = "52af3a7c3cf9994f4e043bed"
        static let asianRestaurant = "4bf58dd8d48988d142941735"
    }
    
    struct Database {
        static let collectionName = "Restaurant"
        
        static let idField = "ID"
        static let nameField = "Name"
        static let phoneField = "Phone"
        static let categoriesField = "Categories"
        static let addressField = "Address"
        static let ratingField = "Rating"
        static let timeField = "Opening"
        static let daysField = "Days"
        static let photoField = "Photos"
        
        
    }

}
