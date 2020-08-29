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
    
    // MARK: - Restaurant Category ID
    struct CategoryID {
        static let japaneseRestaurant = "4bf58dd8d48988d111941735"
        static let cantoneseRestaurant = "52af3a7c3cf9994f4e043bed"
        static let asianRestaurant = "4bf58dd8d48988d142941735"
    }
}
