 //
 //  Response.swift
 //  COVID-19
 //
 //  Created by Ketan Choyal on 2020-04-14.
 //  Copyright © 2020 Ketan Choyal. All rights reserved.
 //

import Foundation

struct Response: Codable {
    let country: String
    let cases: Cases
    let deaths: Deaths
    let tests: Tests
    let day: String
    let time: String

    enum CodingKeys: String, CodingKey {
        case country = "country"
        case cases = "cases"
        case deaths = "deaths"
        case tests = "tests"
        case day = "day"
        case time = "time"
    }
    
//    func getDate(){
//        
//    }
}
