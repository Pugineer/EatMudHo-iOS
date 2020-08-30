//
//  RestaurantModel.swift
//  EatMudHo
//
//  Created by Chris on 24/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import Foundation

struct SearchRestaurantModel: Codable{
    let response: Response
}

struct Response: Codable {
    let venues: [Venues]
}

struct Venues: Codable {
    let name: String
    let id: String
}
