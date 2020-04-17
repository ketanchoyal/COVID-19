//
//  CountryManager.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-14.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import Foundation

class CountryManager {
    static func getCountryData(of country : String, _ completion : @escaping (_ success: Bool, _ country: Country?) -> ()) {
        guard let url = URL(string: NetworkManager.APIURL.getCountryData(country: country)) else {
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
                let countries = try decoder.decode(Countries.self, from: data)
                let country = country.replacingOccurrences(of: "-", with: " ", options: .literal, range: nil)
                let filteredCountries = countries.filter { (flag) -> Bool in
                    flag.name.lowercased() == country.lowercased()
                }
                completion(true, filteredCountries.first)
            } catch {
                completion(false, nil)
            }

        }.resume()
    }
    
    static func getAllCountries(_ completion : @escaping (_ success: Bool, _ flags: Countries?) -> ()) {
        guard let url = URL(string: NetworkManager.APIURL.getAllCountries()) else {
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
                let countries = try decoder.decode(Countries.self, from: data)
                completion(true, countries)
            } catch {
                completion(false, nil)
            }

        }.resume()
    }
}
