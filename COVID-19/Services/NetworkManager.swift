//
//  NetworkManager.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-13.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import Foundation

class NetworkManager {
    
    struct APIURL {
        
        static func covid19DataRequest() -> String {
            return "https://covid-193.p.rapidapi.com/statistics"
        }
        
        static func getCountryFlag(country : String) -> String {
            if country.contains(Character.init("-")) {
                let country = country.replacingOccurrences(of: "-", with: " ", options: .literal, range: nil)
                return "https://restcountries.eu/rest/v2/name/\(country)"
            } else {
                return "https://restcountries.eu/rest/v2/name/\(country)"
            }
        }
    }
    
    struct Header {
        static func header() -> [String : String] {
            return [
                "x-rapidapi-host": "covid-193.p.rapidapi.com",
                "x-rapidapi-key": Constants.Keys.rapid_Covid_Key
            ]
        }
    }
}