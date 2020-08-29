//
//  RestaurantDatabaseModel.swift
//  EatMudHo
//
//  Created by Chris on 29/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import Foundation

struct RestaurantDBModel: Codable{
    let response: Response
}

struct dbResponse: Codable {
    let venue: [Venues]
}

struct dbVenue: Codable {
    let name: String
    let id: String
}
