//
//  RewardsViewController.swift
//  Restaurant Royale
//
//  Created by Joseph Crocker on 11/29/18.
//  Copyright © 2018 Ken Toh. All rights reserved.
//

import UIKit

class RewardsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
  var manager = RestaurantManager()
  var restaurantArray = [Restaurant]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      setupSearch()
      loadData()
      
  }
  
  fileprivate func setupSearch()
  {
    searchBar.delegate = self
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return matches.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
    
    let text = matches[indexPath.row].name
    
    cell.textLabel?.text = text
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = storyboard?.instantiateViewController(withIdentifier: "infoViewController") as! infoViewController
    
    vc.restaurantName = matches[indexPath.row].name
    vc.location = matches[indexPath.row].location
    vc.category = matches[indexPath.row].categories[0]
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if (searchText == ""){
      matches = restaurantArray
    }
    else{
      matches = restaurantArray.filter{$0.name.contains(searchText)}
      matches = matches.sorted { $0.name < $1.name }
    }
    tableView.reloadData()
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
    
    fileprivate var matches: [Restaurant] = []
  
  func loadData(){
    manager.GetEveryRestaurant(completion: { loaded in
      self.restaurantArray = loaded
      for restaurant in self.restaurantArray {
        print(restaurant.name)
        self.matches.append(restaurant)
      }
      self.tableView.reloadData()
      // Do Array things here, like updating the tableview
    })
    matches = restaurantArray
    matches = matches.sorted { $0.name < $1.name}
  }
  
}
