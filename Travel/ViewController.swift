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
import CoreLocation
import UserNotifications

class ViewController: UIViewController, CLLocationManagerDelegate {
    
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
    @IBAction func rememberTicket(_ sender: Any) {
        message.title = "Билеты"
    //    message.subtitle = "Message Subtitle"
        message.body = "У Вас куплены билеты"
        message.badge = 1
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "done", content: message, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    var cityList: [String] = ["TIV", "LON", "OSL", "BLR"]
    let manager: ManagerData = ManagerData()
    let locationManager = CLLocationManager()
    let coder = CLGeocoder()
    var coordinate = CLLocation()
    let message = UNMutableNotificationContent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { didAllow, error in
            if let err = error {
                print(err)
            }
            if didAllow {
                print("get permishen succes")
            }else{
                print("dont get permishen")
            }
        })
        
        ManagerData.sharedManager.getTicketsFromDB()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        //        print("Билеты:\(ManagerData.sharedManager.tickets)")
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(changeViewColor), name: NSNotification.Name(rawValue: "color"), object: nil)
        
        //        manager.loadJSON("OSL", "LON")
        //        manager.loadCountries()
        //        manager.loadCities()
        //        manager.loadAirports()
        
        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        searchButton.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //    func changeViewColor() {
    //        view.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation  = locations.first?.coordinate {
            coordinate = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
            coder.reverseGeocodeLocation(coordinate) { (myPlaces, Error) -> Void in
                if let place = myPlaces?.first {
//                    print(place.locality)
                    if ManagerData.sharedManager.tickets.first == nil {
                        if let city = place.locality {
                            self.fromTextField.text = city
                        }
                    }
                }
            }
        }
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
