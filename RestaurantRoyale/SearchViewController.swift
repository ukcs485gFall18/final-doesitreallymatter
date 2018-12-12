//
//  SearchViewController.swift
//  Restaurant Royale
//
//  Created by Joseph Crocker on 11/29/18.
//  Copyright © 2018 Ken Toh. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      setupSearch()
      setUpData()
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
    
    let text = matches[indexPath.row]
    
    cell.textLabel?.text = text
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "TableViewSegue", sender: self)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if (searchText == ""){
      matches = data
    }
    else{
      matches = data.filter{$0.contains(searchText)}
      //matches.append(data.filter{$0.categories.contains(searchtext)}
      matches = matches.sorted { $0 < $1 }
    }
    tableView.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let dest = segue.destination as! infoViewController
    if (segue.identifier == "TableViewSegue"){
      let match = "whatever"
      dest.recievedData = match
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  private var data: [String] = []
  private var matches: [String] = []
  
  private func setUpData() {
    data.append("Chipotle")
    data.append("Tolly-Ho")
    data.append("Raising Cane's Chicken Fingers")
    data.append("The Local Taco")
    data = data.sorted{$0 < $1}
    matches = data
  }
  
  
}


