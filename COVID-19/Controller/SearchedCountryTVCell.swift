//
//  SearchedCountryTVCell.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-17.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import UIKit

class SearchedCountryTVCell: UITableViewCell {

    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var deathRateLabel: UILabel!
    @IBOutlet weak var recoveryRateLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(countryData : Response) {
        countryNameLabel.text = countryData.country
        deathsLabel.text = countryData.deaths.total.description
        recoveredLabel.text = countryData.cases.recovered.description
        confirmedLabel.text = countryData.cases.total.description
        calculateRates(countryData: countryData)
    }
    
    func calculateRates(countryData : Response) {
        let closedCase = countryData.deaths.total + countryData.cases.recovered
        let deathRate = (Double(countryData.deaths.total) * 100.0)/Double(closedCase)
        let recoveryRate = (Double(countryData.cases.recovered) * 100.0)/Double(closedCase)
        deathRateLabel.text = String(format:"%.2f", deathRate) + "%"
        recoveryRateLabel.text = String(format:"%.2f", recoveryRate) + "%"
    }

}
