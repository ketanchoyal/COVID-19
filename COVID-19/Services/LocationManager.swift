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
        FlagManager.getAllCountries { (success, countries) in
            if success {
                guard let countries = countries else {
                    print("Here 1")
                    completion(false, nil)
                    return
                }
                print(countries.count)
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
                print("Nearest : \(nearestCountry?.name)")
                print("success 1")
                completion(true, nearestCountry)
            } else {
                print("Here 2")
                completion(false, nil)
            }
        }
    }
    
    static private func getCountryCovidDataByLocation(country : Country, _ completion : @escaping (_ success : Bool, _ coronaDataResponse : Response?) -> ()) {
        CovidManager.getCountriesData { (success, coronaData) in
            if success {
                guard let coronaData = coronaData else {
                    print("Here 3")
                    completion(false, nil)
                    return
                }
                print("Data : \(coronaData.response.count)")
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
                print("success 2")
                print(filteredCoronaData.count)
                completion(true, filteredCoronaData.first)
            } else {
                print("Here 4")
                completion(false, nil)
            }
        }
    }
    
    static func getNearestCountryCovidData(currentLoaction : CLLocation, _ completion : @escaping (_ success : Bool, _ coronaData : Response?, _ country : Country?) -> ()) {
        self.getNearestCountry(currentLocation: currentLoaction) { (success, country) in
            if success {
                guard let country = country else {
                    print("Here 5")
                    completion(false, nil, nil)
                    return
                }
                
                self.getCountryCovidDataByLocation(country: country) { (success, response) in
                    if success {
                        guard let response = response else {
                            print("Here 6")
                            completion(false, nil, nil)
                            return
                        }
                        print("success 3")
                        completion(true, response, country)
                    } else {
                        print("Here 7")
                        completion(false, nil,nil)
                    }
                }
            } else {
                print("Here 8")
                completion(false, nil, nil)
            }
        }
    }
}


            //return countriesCoordinates.min(by: { $0.distance(from: userLocation) < $1.distance(from: userLocation) })
        //}
            
            
//            static func getNearestCountryData(_ covidData: CovidData, _ countryLocation: CLLocation) -> Country?{
//                print(countryLocation.coordinate.latitude)
//                print(countryLocation.coordinate.longitude)
//                let f = covidData.areas.filter({ $0.lat!.isEqual(to: countryLocation.coordinate.latitude) &&
//                    $0.long!.isEqual(to: countryLocation.coordinate.longitude)
//                })
//                print("\n\(f)")
