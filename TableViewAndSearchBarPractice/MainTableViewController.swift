//
//  MainTableViewController.swift
//  TableViewAndSearchBarPractice
//
//  Created by Denis Markov on 7/23/18.
//  Copyright © 2018 Denis Markov. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var restaurants = Constants().restaurants
    
    final let rowHeight = Constants().mainTableRowHeight
    
    var currentRestaurantInfo: RestaurantModel?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredRestaurants = [RestaurantModel]()
    
    @IBOutlet var searchFooter: SearchFooterViewController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "cell")
        tableView.rowHeight = CGFloat(rowHeight)
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Restaurants"
        searchController.searchBar.backgroundColor = UIColor.white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        // Setup the search footer
        tableView.tableFooterView = searchFooter
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            searchFooter.setIsFilteringToShow(filteredItemCount: filteredRestaurants.count, of: restaurants.count)
            return filteredRestaurants.count
        }
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        var cellInfo: RestaurantModel
        if isFiltering() {
            cellInfo = filteredRestaurants[indexPath.row]
        } else {
            cellInfo = restaurants[indexPath.row]
        }
        cell.initCell(cellInfo.imageName, name: cellInfo.header, adress: cellInfo.adress)
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            restaurants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering() {
            currentRestaurantInfo = filteredRestaurants[indexPath.row]
        } else {
            currentRestaurantInfo = restaurants[indexPath.row]
        }
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RestaurantDetailViewController {
            destination.restaurantDetails = currentRestaurantInfo
        }
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredRestaurants = restaurants.filter({( restaurant : RestaurantModel) -> Bool in
            guard let restaurantName = restaurant.header else { return false }
            return (restaurantName.lowercased().contains(searchText.lowercased()))
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    

}

extension MainTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
