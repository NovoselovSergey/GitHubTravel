//
//  ListOfFlightsTableViewController.swift
//  Travel
//
//  Created by Sergey Novoselov on 09.07.17.
//  Copyright © 2017 Sergey Novoselov. All rights reserved.
//

import UIKit

class ListOfFlightsTableViewController: UITableViewController {
    
    let manager: ManagerData = ManagerData()
    var classTicketList: [Tickets] = []
    var cityFrom: String = ""
    var cityWhere: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ManagerData.sharedManager.getTicketsFromDB()
        manager.loadJSON(cityFrom, cityWhere)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadTickets), name: NSNotification.Name(rawValue: "refresh"), object: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ManagerData.sharedManager.tickets.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        
        let label1: UILabel = cell.viewWithTag(1) as! UILabel
        label1.text = String(ManagerData.sharedManager.tickets[indexPath.row].value)
        let label2: UILabel = cell.viewWithTag(2) as! UILabel
        label2.text = String(ManagerData.sharedManager.tickets[indexPath.row].codeFrom)
        let label3: UILabel = cell.viewWithTag(3) as! UILabel
        label3.text = String(ManagerData.sharedManager.tickets[indexPath.row].codeWhere)
        
        return cell
    }
    
    func loadTickets() {
        DispatchQueue.main.async {
            print("99. refresh \(Thread.current)")
            self.tableView.reloadData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "tickets"), object: nil)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
