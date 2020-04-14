//
//  CovidManager.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-14.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import Foundation

class CovidManager {
    static func getCountriesData(_ completion : @escaping (_ success: Bool, _ corona: Corona?) -> ()) {
        guard let url = URL(string: NetworkManager.APIURL.covid19DataRequest()) else {
            completion(false, nil)
            return
        }
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = NetworkManager.Header.header()
        
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data else {
                print("here 1")
                completion(false, nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                let corona = try decoder.decode(Corona.self, from: data)
                completion(true, corona)
            } catch {
                print("here 2")
                completion(false, nil)
            }
        }
        ).resume()
    }
}
