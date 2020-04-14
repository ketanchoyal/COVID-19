//
//  ViewController.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-13.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var deaths : Int = 0;
        CovidManager.getCountriesData { (success, corona) in
            if success {
                guard let corona = corona else {
                    return
                }
                var x = corona.response.filter { (res) -> Bool in
                    res.country == "India"
                }
                print(x.first?.cases)
                for res in corona.response {
                    deaths = deaths + res.cases.total
                }
                print(deaths)
                print(corona.response.count)
                print(corona.response[1].country)
                
            } else {
                print("fail")
            }
        }
    }


}

