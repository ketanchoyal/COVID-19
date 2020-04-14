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
}
