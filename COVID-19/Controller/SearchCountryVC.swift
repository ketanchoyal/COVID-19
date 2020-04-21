//
//  SearchCountryVC.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-17.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import UIKit

class SearchCountryVC: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var countriesTableView: UITableView!
    var filteredCountries : [Response]? = []
    var continents : [Response]?
    
    @IBOutlet weak var searchCountryBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        searchCountryBar.delegate = self
        searchCountryBar.enablesReturnKeyAutomatically = true
        
        initVC()
    }
    
    func initVC() {
        continents = CovidManager.corona?.getSortedContinents()
        filteredCountries = continents
        countriesTableView.reloadData()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let coronaData = CovidManager.corona {
            if (searchText.isInteger) {
                if (Int(searchText)! < coronaData.response.count - 6) {
                    filteredCountries = [coronaData.getSortedCountries()[(Int(searchText) ?? 2) - 1 ]]
                } else {
                    filteredCountries = [coronaData.getSortedCountries()[coronaData.getSortedCountries().count - 1]]
                }
            } else {
                filteredCountries = searchText.isEmpty ? continents : coronaData.getSortedCountries().filter { $0.country.lowercased().contains(searchText.lowercased())}
            }
        }
        countriesTableView.reloadData()
    }
}

extension SearchCountryVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "country", for: indexPath) as? SearchedCountryTVCell else {
            return UITableViewCell()
        }
        
        if let filteredCountries = filteredCountries {
            let index = CovidManager.corona?.getSortedCountries().firstIndex(where: { (response) -> Bool in
                if response.country == filteredCountries[indexPath.row].country {
                    return true
                } else {
                    return false
                }
            })
            let continentRank = CovidManager.corona?.getSortedContinents().firstIndex(where: { (response) -> Bool in
                if response.country == filteredCountries[indexPath.row].country {
                    return true
                } else {
                    return false
                }
            })
            
            cell.configureCell(countryData: filteredCountries[indexPath.row], countryRank: ((index ?? continentRank)! + 1).description)
        } else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}
