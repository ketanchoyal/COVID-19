//
//  TodayViewController.swift
//  WorldCount
//
//  Created by Ketan Choyal on 2020-04-21.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    var worldData : Response?
    
    @IBOutlet var confirmedLabel: UILabel!
    @IBOutlet var recoveredLabel: UILabel!
    @IBOutlet var deathLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCovidData()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        CovidManager.getCountriesData { (success, coronaData) in
            if success {
                guard let coronaData = coronaData else {
                    completionHandler(NCUpdateResult.failed)
                    return
                }
                let worldData = coronaData.response.filter { (data) -> Bool in
                    data.country == "All"
                }
                if let worldData = worldData.first {
                    self.worldData = worldData
                    completionHandler(NCUpdateResult.newData)
                }
            }
        }
        
        if let worldData = worldData {
            DispatchQueue.main.async {
                self.deathLabel.text = worldData.deaths.total.description
                self.confirmedLabel.text = worldData.cases.total.description
                self.recoveredLabel.text = worldData.cases.recovered.description
            }
        }
        completionHandler(NCUpdateResult.newData)
    }
    
    
    fileprivate func getCovidData() {
        // Do any additional setup after loading the view.
        CovidManager.getCountriesData { (success, coronaData) in
            if success {
                guard let coronaData = coronaData else {
                    return
                }
                let worldData = coronaData.response.filter { (data) -> Bool in
                    data.country == "All"
                }
                if let worldData = worldData.first {
                    DispatchQueue.main.async {
                        self.deathLabel.text = worldData.deaths.total.description
                        self.confirmedLabel.text = worldData.cases.total.description
                        self.recoveredLabel.text = worldData.cases.recovered.description
                    }
                }
                
                
            }
        }
    }
    
}
