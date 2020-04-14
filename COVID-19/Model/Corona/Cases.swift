//
//  Cases.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-14.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import Foundation

struct Cases: Codable {
    let new: String?
    let active: Int
    let critical: Int
    let recovered: Int
    let total: Int

    enum CodingKeys: String, CodingKey {
        case new = "new"
        case active = "active"
        case critical = "critical"
        case recovered = "recovered"
        case total = "total"
    }
}
