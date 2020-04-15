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
        
        FlagManager.getFlagOf(of: "sri-lanka") { (success, flag) in
            if success {
                guard let flag = flag else {
                    return
                }
                print(flag.flagLink)
            }
        }
        
        CovidManager.getCountriesData { (success, corona) in
            if success {
                guard let corona = corona else {
                    return
                }
                let x = corona.response.filter { (res) -> Bool in
                    res.country == "All"
                }
                print(x.first?.cases)
            } else {
                print("fail")
            }
        }
    }
    
    
}

