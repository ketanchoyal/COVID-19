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

    @IBOutlet weak var searchCountryBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        searchCountryBar.delegate = self
        searchCountryBar.enablesReturnKeyAutomatically = true
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCountries = searchText.isEmpty ? [] : CovidManager.corona?.response.filter { $0.country.lowercased().contains(searchText.lowercased())}
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
            cell.configureCell(countryData: filteredCountries[indexPath.row])
        } else {
            return UITableViewCell()
        }

        return cell
    }
    
    
}
