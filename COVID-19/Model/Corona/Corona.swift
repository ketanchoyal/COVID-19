//
//  Corona.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-14.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import Foundation

struct Corona: Codable {
    let coronaGet: String
    let results: Int
    let response: [Response]

    enum CodingKeys: String, CodingKey {
        case coronaGet = "get"
        case results = "results"
        case response = "response"
    }
    
    func filterData() -> [Response] {
        var filteredData : [Response] = []
        for i in 0...self.response.count - 2 {
            if (self.response[i].day != self.response[i + 1].day) {
                filteredData.append(response[i])
            }
        }
        return filteredData
    }
    
    func getSortedCountries() -> [Response]{
        let notRequired = ["Europe", "Asia", "Australia", "South-America", "North-America","Africa", "All"]
        
        let countriesData = self.response.filter { (response) -> Bool in
            if notRequired.contains(response.country) {
                return false
            } else {
                return true
            }
        }
        return countriesData.sorted { (response1, response2) -> Bool in
            return response1.cases.total > response2.cases.total
        }
    }
    
    func getSortedContinents() -> [Response]{
        let continents = ["Europe", "Asia", "Australia", "South-America", "North-America","Africa"]
        
        let continentData = self.response.filter { (response) -> Bool in
            if continents.contains(response.country) {
                return true
            } else {
                return false
            }
        }
        return continentData.sorted { (response1, response2) -> Bool in
            return response1.cases.total > response2.cases.total
        }
    }
}
