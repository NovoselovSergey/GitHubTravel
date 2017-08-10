//
//  ViewController.swift
//  Travel
//
//  Created by Sergey Novoselov on 05.07.17.
//  Copyright © 2017 Sergey Novoselov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var whereLabel: UILabel!
    @IBOutlet weak var thereLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var whereTextField: UITextField!
    @IBAction func pressFrom(_ sender: Any) {
        performSegue(withIdentifier: "addCity", sender: nil)
    }
    @IBAction func pressWhere(_ sender: Any) {
        performSegue(withIdentifier: "addCity", sender: nil)
    }
    
    var cityList: [String] = ["TIV", "LON", "OSL", "BLR"]
    let manager: ManagerData = ManagerData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ManagerData.sharedManager.getTicketsFromDB()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        //        print("Билеты:\(ManagerData.sharedManager.tickets)")
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(changeViewColor), name: NSNotification.Name(rawValue: "color"), object: nil)
        
        //        manager.loadJSON("OSL", "LON")
        //        manager.loadCountries()
        //        manager.loadCities()
        //        manager.loadAirports()
        
        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //    func changeViewColor() {
    //        view.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goTickets" {
            if fromTextField.text != "" && whereTextField.text != "" {
                let destinationVC = segue.destination as! ListOfFlightsTableViewController
                destinationVC.cityFrom = fromTextField.text!
                destinationVC.cityWhere = whereTextField.text!
            }
        }
    }
}
