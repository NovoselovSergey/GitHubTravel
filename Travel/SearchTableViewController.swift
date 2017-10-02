//
//  SearchViewController.swift
//  Travel
//
//  Created by Sergey Novoselov on 10.08.17.
//  Copyright © 2017 Sergey Novoselov. All rights reserved.
//

import UIKit
import SwiftyJSON
import FirebaseDatabase
import RealmSwift

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var resultSearchController: UISearchController!
    var searchResult: [String] = []
    var locallist: [String] = []
    let manager: ManagerData = ManagerData()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.searchResult.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
            cell.textLabel?.text = self.searchResult[indexPath.row]
            return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
//            locallist = searchResult
//            searchResult = []
            filterContent(searchText: searchText)
            tableView.reloadData()
        }
        
        
    }
    
    func filterContent(searchText: String) {
        
//        if searchText.characters.count == 1 {
            Database.database().reference().child("Countries").observe(.value, with: { snapshot in
                if let value = snapshot.value {
                    print(value)
                    let json = JSON(value)
                    for (_, subJSON) in json {
                        self.searchResult.append(subJSON["name"].stringValue)
                        self.tableView.reloadData()
                    }
                }
            })
//        }
//        else {
//            for value in locallist {
//                if value.contains(searchText) {
//                    searchResult.append(value)
//                    self.tableView.reloadData()
//                }
//            }
//        }
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
