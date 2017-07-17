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
    @IBAction func searchButtonAction (_ sender: Any) {
        if !whereLabel.text!.isEmpty {
            manager.loadJSON(fromLabel.text!, whereLabel.text!)
        }
    }
    
    var cityList: [String] = ["TIV", "LON", "OSL", "BLR"]
    let manager: ManagerData = ManagerData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        manager.loadJSON("OSL", "LON")
        
        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
