//
//  Rest.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-14.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import Foundation

struct Tests: Codable {
    let total: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
    }
}
