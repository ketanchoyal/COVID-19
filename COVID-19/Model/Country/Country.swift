//
//  Country.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-14.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import Foundation
import CoreLocation

struct Country: Codable {
    let name: String
    let population: Int
    let latlng: [Double]
    let nativeName: String
    let alpha2Code: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case population = "population"
        case latlng = "latlng"
        case nativeName = "nativeName"
        case alpha2Code = "alpha2Code"
    }
    
    func getLatLong() -> CLLocation {
        return CLLocation(latitude: self.latlng[0], longitude: self.latlng[1])
    }
    
    func getFlagLink() -> String {
        return "https://www.countryflags.io/\(self.alpha2Code)/flat/64.png"
    }
}
