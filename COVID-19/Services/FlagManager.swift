//
//  FlagsManager.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-14.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import Foundation

class FlagManager {
    static func getFlagOf(of country : String, _ completion : @escaping (_ success: Bool, _ flag: Flag?) -> ()) {
        guard let url = URL(string: NetworkManager.APIURL.getCountryFlag(country: country)) else {
            completion(false, nil)
            return
        }
        URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(false, nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                let flags = try decoder.decode(Flags.self, from: data)
                print(flags.count)
                let country = country.replacingOccurrences(of: "-", with: " ", options: .literal, range: nil)
                let flag = flags.filter { (flag) -> Bool in
                    flag.name.lowercased() == country.lowercased()
                }
                completion(true, flag.first)
            } catch {
                completion(false, nil)
            }

        }.resume()
    }
}
