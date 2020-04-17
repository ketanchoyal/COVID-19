//
//  LocationManager.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-15.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager {
    
    static private func getNearestCountry(currentLocation : CLLocation,_ completion : @escaping (_ success : Bool, _ country : Country?) -> ()) {
        CountryManager.getAllCountries { (success, countries) in
            if success {
                guard let countries = countries else {
                    completion(false, nil)
                    return
                }
                let filteredCountries = countries.filter { (country) -> Bool in
                    if country.name != "United States Minor Outlying Islands" {
                        return true
                    } else {
                        return false
                    }
                }
                let nearestCountry = filteredCountries.min { (country1, country2) -> Bool in
                    country1.getLatLong().distance(from: currentLocation) < country2.getLatLong().distance(from: currentLocation)
                }
                completion(true, nearestCountry)
            } else {
                completion(false, nil)
            }
        }
    }
    
    static private func getCountryCovidDataByLocation(country : Country, _ completion : @escaping (_ success : Bool, _ coronaDataResponse : Response?) -> ()) {
        CovidManager.getCountriesData { (success, coronaData) in
            if success {
                guard let coronaData = coronaData else {
                    completion(false, nil)
                    return
                }
                let filteredCoronaData = coronaData.response.filter { (response) -> Bool in
                    if (response.country.lowercased() == country.name.lowercased().replacingOccurrences(of: " ", with: "-", options: .literal, range: nil)) {
                        return true
                    }
                    if (response.country == "USA") {
                        if ("United States of America".lowercased() == country.name.lowercased()) {
                            return true
                        }
                    }
                    return false
                }
                completion(true, filteredCoronaData.first)
            } else {
                completion(false, nil)
            }
        }
    }
    
    static func getNearestCountryCovidData(currentLoaction : CLLocation, _ completion : @escaping (_ success : Bool, _ coronaData : Response?, _ country : Country?) -> ()) {
        self.getNearestCountry(currentLocation: currentLoaction) { (success, country) in
            if success {
                guard let country = country else {
                    completion(false, nil, nil)
                    return
                }
                
                self.getCountryCovidDataByLocation(country: country) { (success, response) in
                    if success {
                        guard let response = response else {
                            completion(false, nil, nil)
                            return
                        }
                        completion(true, response, country)
                    } else {
                        completion(false, nil,nil)
                    }
                }
            } else {
                completion(false, nil, nil)
            }
        }
    }
}
