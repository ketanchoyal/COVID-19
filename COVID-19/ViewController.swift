//
//  ViewController.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-13.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var worldDeathLabel: UILabel!
    @IBOutlet weak var worldConfirmedLabel: UILabel!
    @IBOutlet weak var worldRecoveredLabel: UILabel!
    @IBOutlet weak var worldDeathPercentageLabel: UILabel!
    @IBOutlet weak var worldRecoveryPercentageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromApi()
    }
    
    func getDataFromApi() {
        CovidManager.getCountriesData { (success, coronaData) in
            if success {
                guard let coronaData = coronaData else {
                    return
                }
                
                let worldData = coronaData.response.filter { (data) -> Bool in
                    data.country == "All"
                }
                
                if  worldData.count > 0 {
                    self.setWorldData(worldData: worldData.first!)
                }
                
            }
        }
    }
    
    func setWorldData(worldData : Response) {
        DispatchQueue.main.async {
            self.worldDeathLabel.text = worldData.deaths.total.description
            self.worldConfirmedLabel.text = worldData.cases.total.description
            self.worldRecoveredLabel.text = worldData.cases.recovered.description
        }
    }
}

