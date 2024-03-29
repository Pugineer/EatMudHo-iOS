//
//  RestaurantDatabaseModel.swift
//  EatMudHo
//
//  Created by Chris on 29/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import Foundation

struct RestaurantModel: Codable{
    let response: DBResponse
}

struct DBResponse: Codable {
    let venue: Venue
}

struct Venue: Codable {
    let name: String
    let id: String
    let rating: Double?
    let contact: Contact?
    let location: Location?
    let hours: Hours?
    let categories: [Categoies]
    let listed: Listed? // which is photos
}

struct Categoies: Codable {
    let name: String
}
struct Contact: Codable {
    let phone: String?
}
struct Location: Codable {
    let address: String
}

// MARK: - Opening hours fetching

struct Hours: Codable {
    let timeframes: [TimeFrames]
}

struct TimeFrames: Codable {
    let days: String?
    let open: [OpenHour]?
}

struct OpenHour: Codable {
    let renderedTime: String?
}

// MARK: - Photo fetching

struct Listed: Codable {
    let groups: [Groups]?
}

struct Groups: Codable {
    let items: [Items]
}

struct Items: Codable {
    let photo: Photo?
}

struct Photo: Codable {
    let prefix: String
    let suffix: String
}
