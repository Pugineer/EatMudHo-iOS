//
//  APIRequest.swift
//  EatMudHo
//
//  Created by Chris on 24/8/2020.
//  Copyright © 2020 Pixel Unity. All rights reserved.
//

import Foundation

struct APIRequest {
    var latitude: Double?
    var longitude: Double?
    var time: Int?
    var category: Array<String>? = []
    var mode: String?
}
