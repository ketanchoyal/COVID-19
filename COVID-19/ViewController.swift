//
//  ViewController.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-13.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var worldDeathLabel: UILabel!
    @IBOutlet weak var worldConfirmedLabel: UILabel!
    @IBOutlet weak var worldRecoveredLabel: UILabel!
    @IBOutlet weak var worldDeathPercentageLabel: UILabel!
    @IBOutlet weak var worldRecoveryPercentageLabel: UILabel!
    @IBOutlet weak var lineChartUIView: LineChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartUIView.delegate = self
        
        lineChartUIView.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 0)
        lineChartUIView.setViewPortOffsets(left: 5, top: 5, right: 5, bottom: 5)
        lineChartUIView.dragEnabled = true
        lineChartUIView.setScaleEnabled(true)
        lineChartUIView.pinchZoomEnabled = false
        lineChartUIView.maxHighlightDistance = 10

        lineChartUIView.xAxis.enabled = false

        lineChartUIView.rightAxis.enabled = false
        lineChartUIView.leftAxis.enabled = false
        lineChartUIView.legend.enabled = true
        
        lineChartUIView.animate(xAxisDuration: 2, yAxisDuration: 2)
        
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
        
        CovidManager.getCountryHistory(country: "All") { (success, worldHistoryData) in
            if success {
                guard let worldHistory = worldHistoryData else {
                    return
                }
                DispatchQueue.main.async {
                    self.plotChart(data: worldHistory.response.reversed())
                }
            }
        }
    }
    
    func plotChart(data : [Response]) {
        let yVals1 = (0..<data.count).map { (i) -> ChartDataEntry in
            let val = Double(data[i].cases.total)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let yVals2 = (0..<data.count).map { (i) -> ChartDataEntry in
            let val = Double(data[i].deaths.total)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let yVals3 = (0..<data.count).map { (i) -> ChartDataEntry in
            let val = Double(data[i].cases.recovered)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = LineChartDataSet(entries: yVals1, label: "Total")
        set1.mode = .linear
        set1.lineWidth = 1.5
        set1.cubicIntensity = 0.05
        set1.circleRadius = 0.8
        set1.setCircleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        set1.highlightColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        set1.fillColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        set1.fillFormatter = CubicLineSampleFillFormatter()
        set1.drawFilledEnabled = true
        set1.setColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        set1.drawHorizontalHighlightIndicatorEnabled = false
        
        let set2 = LineChartDataSet(entries: yVals2, label: "Deaths")
        set2.mode = .linear
        set2.lineWidth = 1.5
        set2.circleRadius = 0.8
        set2.setCircleColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
        set2.highlightColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        set2.fillColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        set2.fillFormatter = CubicLineSampleFillFormatter()
        set2.drawFilledEnabled = true
        set2.setColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
        set2.drawHorizontalHighlightIndicatorEnabled = false
        
        let set3 = LineChartDataSet(entries: yVals3, label: "Recovered")
        set3.mode = .linear
        set3.lineWidth = 1.5
        set3.circleRadius = 0.8
        set3.setCircleColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        set3.highlightColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        set3.fillColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        set3.fillFormatter = CubicLineSampleFillFormatter()
        set3.drawFilledEnabled = true
        set3.setColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        set3.drawHorizontalHighlightIndicatorEnabled = false
        
        let data = LineChartData(dataSets: [set1, set2, set3])
        data.setValueFont(.systemFont(ofSize: 10, weight: .light))
        data.setDrawValues(true)
        self.lineChartUIView.data = data
    }
    
    func setWorldData(worldData : Response) {
        DispatchQueue.main.async {
            self.worldDeathLabel.text = worldData.deaths.total.description
            self.worldConfirmedLabel.text = worldData.cases.total.description
            self.worldRecoveredLabel.text = worldData.cases.recovered.description
            self.calculateRates(worldData: worldData)
        }
    }
    
    func calculateRates(worldData : Response) {
        let deathRate = (Double(worldData.deaths.total) * 100.0)/Double(worldData.cases.total)
        let recoveryRate = (Double(worldData.cases.recovered) * 100.0)/Double(worldData.cases.total)
        worldDeathPercentageLabel.text = String(format:"%.2f", deathRate) + "%"
        worldRecoveryPercentageLabel.text = String(format:"%.2f", recoveryRate) + "%"
    }
}

private class CubicLineSampleFillFormatter: IFillFormatter {
    func getFillLinePosition(dataSet: ILineChartDataSet, dataProvider: LineChartDataProvider) -> CGFloat {
        return -10
    }
}

