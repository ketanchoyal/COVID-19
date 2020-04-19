//
//  ViewController.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-13.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import UIKit
import Charts
import CoreLocation

class MainVC: UIViewController, ChartViewDelegate {
    
    let locationManager = CLLocationManager()
    var navigationBarActivityIndicator = UIActivityIndicatorView()
    var chartActivityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var worldDeathLabel: UILabel!
    @IBOutlet weak var worldConfirmedLabel: UILabel!
    @IBOutlet weak var worldRecoveredLabel: UILabel!
    @IBOutlet weak var worldDeathRateLabel: UILabel!
    @IBOutlet weak var worldRecoveryRateLabel: UILabel!
    @IBOutlet weak var lineChartUIView: LineChartView!
    @IBOutlet weak var countryIconImageView: UIImageView!
    @IBOutlet weak var countryDeathLabel: UILabel!
    @IBOutlet weak var countryConfirmedLabel: UILabel!
    @IBOutlet weak var countryRecoveredLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet var activityIndicatorNavigationBarBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let imageView = UIImageView(frame:  CGRect(x: 0, y: 0, width: 20, height: 20))
//        imageView.image = UIImage(named: "virus")
//        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//        let item = UIBarButtonItem(customView: imageView)
//        self.navigationItem.setLeftBarButton(item, animated: true)
        
        locationManager.delegate = self
        lineChartUIView.delegate = self
        setUpChart()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromApi()
    }
    @IBAction func refreshDataPressed(_ sender: Any) {
        getDataFromApi()
    }
    
    func startIndicator() {
        navigationBarActivityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        navigationBarActivityIndicator.color = .gray
        let barButton = UIBarButtonItem(customView: navigationBarActivityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
        navigationBarActivityIndicator.startAnimating()
        
        chartActivityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        chartActivityIndicator.color = .white
        lineChartUIView.addSubview(chartActivityIndicator)
        chartActivityIndicator.startAnimating()
    }

    func stopIndicator() {
        navigationBarActivityIndicator.stopAnimating()
        navigationItem.setRightBarButton(activityIndicatorNavigationBarBtn, animated: true)
    }
    
    func setUpChart() {
        lineChartUIView.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 0)
        lineChartUIView.setViewPortOffsets(left: 0, top: 0, right: 0, bottom: 5)
        lineChartUIView.dragEnabled = true
        lineChartUIView.setScaleEnabled(true)
        lineChartUIView.pinchZoomEnabled = false
        lineChartUIView.maxHighlightDistance = 10
        lineChartUIView.xAxis.enabled = false
        lineChartUIView.rightAxis.enabled = false
        lineChartUIView.leftAxis.enabled = false
        lineChartUIView.legend.enabled = true
        lineChartUIView.legend.textColor = .white
        lineChartUIView.animate(xAxisDuration: 3, yAxisDuration: 3)
    }
    
    func getDataFromApi() {
        startIndicator()
        locationManager.startUpdatingLocation()
        CovidManager.getCountriesData { (success, coronaData) in
            if success {
                guard let coronaData = coronaData else {
                    self.stopIndicator()
                    return
                }
                let worldData = coronaData.response.filter { (data) -> Bool in
                    data.country == "All"
                }
                if  worldData.count > 0 {
                    self.setWorldData(worldData: worldData.first!)
                }
            } else {
                self.stopIndicator()
            }
        }
        
        CovidManager.getCountryHistory(country: "All") { (success, worldHistoryData) in
            if success {
                guard let worldHistory = worldHistoryData else {
                    self.stopIndicator()
                    self.chartActivityIndicator.stopAnimating()
                    return
                }
                DispatchQueue.main.async {
                    self.plotChart(data: worldHistory.response.reversed())
                    self.chartActivityIndicator.stopAnimating()
                    self.stopIndicator()
                }
            } else {
                self.chartActivityIndicator.stopAnimating()
                self.stopIndicator()
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
        set1.cubicIntensity = 1
        set1.circleRadius = 0.8
        set1.setCircleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        set1.highlightColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        set1.fillColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
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
        set3.drawFilledEnabled = true
        set3.setColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        set3.drawHorizontalHighlightIndicatorEnabled = false
        
        let data = LineChartData(dataSets: [set1, set2, set3])
        data.setValueFont(.systemFont(ofSize: 12, weight: .semibold))
        data.setValueTextColor(.white)
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
        let closedCase = worldData.deaths.total + worldData.cases.recovered
        let deathRate = (Double(worldData.deaths.total) * 100.0)/Double(closedCase)
        let recoveryRate = (Double(worldData.cases.recovered) * 100.0)/Double(closedCase)
        worldDeathRateLabel.text = String(format:"%.2f", deathRate) + "%"
        worldRecoveryRateLabel.text = String(format:"%.2f", recoveryRate) + "%"
    }
}

extension MainVC : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            LocationManager.getNearestCountryCovidData(currentLoaction: location) { (success, response, country) in
                if success {
                    guard let response = response else {
                        return
                    }
                    guard let country = country else {
                        self.setCountryData(countryData: response, country: nil)
                        return
                    }
                    self.setCountryData(countryData: response, country: country)
                    self.locationManager.stopUpdatingLocation()
                }
            }
        }
    }
    
    func setCountryData(countryData : Response, country : Country!) {
        DispatchQueue.main.async {
            self.countryDeathLabel.text = countryData.deaths.total.description
            self.countryConfirmedLabel.text = countryData.cases.total.description
            self.countryRecoveredLabel.text = countryData.cases.recovered.description
            self.countryNameLabel.text = country.name
            self.countryIconImageView.load(url: URL(string: country.getFlagLink())!)
        }
    }
}
