//
//  ManagerData.swift
//  Travel
//
//  Created by Sergey Novoselov on 09.07.17.
//  Copyright © 2017 Sergey Novoselov. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import SwiftyJSON

private let _sharedManager = ManagerData()

class ManagerData {
    
    //--------------------------------------------
    //    singltone
    class var sharedManager: ManagerData {
        return _sharedManager
    }
    //--------------------------------------------
    //--------------------------------------------
    private var _tickets: [Tickets] = []
    
    var tickets: [Tickets] {
        var ticketsCopy: [Tickets]!
        concurrentQueue.sync {
            ticketsCopy = self._tickets
        }
        return ticketsCopy
    }
    //--------------------------------------------
    //    data from DB
    func getTicketsFromDB() {
        let realm = try! Realm()
        self._tickets = Array(realm.objects(Tickets.self))
    }
    //--------------------------------------------
    
    func loadJSON(_ cityFrom: String, _ cityWhere: String) {
        //        let realm = try! Realm()
        let url = "http://api.travelpayouts.com/v2/prices/latest?origin=\(cityFrom)&currency=rub&destination=\(cityWhere)&period_type=year&page=1&limit=30&show_to_affiliates=true&sorting=price&trip_class=0&token="
        
        Alamofire.request(url, method: .get).validate().responseJSON(queue: concurrentQueue) { response in
            print("1. startQuene \(Thread.current)")
            switch response.result {
            case .success(let value):
                let jsonTicket = JSON(value)
                //                print("City: \(json["data"]["destination"].stringValue)")
                for (_, subJson) in jsonTicket["data"] {
                    let ticket = Tickets()
                    ticket.codeFrom = subJson["origin"].stringValue
                    ticket.codeWhere = subJson["destination"].stringValue
                    ticket.value = subJson["value"].intValue
                    print(ticket)
                    
                    print("2. load \(Thread.current)")
                    self.TicketWriteDB(data: ticket)
                    
                    //                    try! realm.write {
                    //                        realm.add(ticket)
                    //                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func TicketWriteDB(data: Tickets) {
        let realm = try! Realm()
        //                realm.beginWrite()
        try! realm.write {
            realm.add(data)
        }
        //                try! realm.commitWrite()
        print("3. write \(Thread.current)")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
    }
    
    func loadCountries() {
        //        let realm = try! Realm()
        let url = "http://api.travelpayouts.com/data/countries.json"
        
        Alamofire.request(url, method: .get).validate().responseJSON(queue: concurrentQueue) { response in
            print("4. startQuene \(Thread.current)")
            
            switch response.result {
            case .success(let value):
                let jsonCountries = JSON(value)
                //                print("JSON: \(jsonCountries)")
                concurrentQueue.async {
                    for (_, subJson) in jsonCountries {
                        let country = Countries()
                        country.code = subJson["code"].stringValue
                        country.name = subJson["name"].stringValue
                        country.currency = subJson["currency"].stringValue
                        country.nameRu = subJson["name_translations"]["ru"].stringValue
                        print(country)
                        
                        print("5. load \(Thread.current)")
                        self.countriesWriteDB(data: country)
                    }
                    
                    //                    try! realm.write {
                    //                        realm.add(country)
                    //                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func countriesWriteDB(data: Countries) {
        let realm = try! Realm()
        //                realm.beginWrite()
        try! realm.write {
            realm.add(data)
        }
        //                try! realm.commitWrite()
        print("6. write \(Thread.current)")
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "color"), object: nil)
    }
    
    func loadCities() {
        let url = "http://api.travelpayouts.com/data/cities.json"
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            print("7. startQuene \(Thread.current)")
            switch response.result {
            case .success(let value):
                let jsonCities = JSON(value)
                //                print("JSON: \(json)")
                concurrentQueue.async {
                    for (_, subJson) in jsonCities {
                        let city = Cities()
                        city.code = subJson["code"].stringValue
                        city.name = subJson["name"].stringValue
                        city.time_zone = subJson["time_zone"].stringValue
                        city.nameRu = subJson["name_translations"]["ru"].stringValue
                        city.country_code = subJson["country_code"].stringValue
                        print(city)
                        
                        print("8. load \(Thread.current)")
                        self.citiesWriteDB(data: city)
                        
                        //                    try! realm.write {
                        //                        realm.add(country)
                        //                    }
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func citiesWriteDB(data: Cities) {
        let realm = try! Realm()
        //                realm.beginWrite()
        try! realm.write {
            realm.add(data)
        }
        //                try! realm.commitWrite()
        print("9. write \(Thread.current)")
    }
    
    func loadAirports() {
        let url = "http://api.travelpayouts.com/data/airports.json"
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

var semaphore = DispatchSemaphore(value: 0) // создаем семафор
let playGrp = DispatchGroup() // создаем группу
//let queue = DispatchQueue(label: "com.dispatchgroup", attributes: .initiallyInactive, target: .main)
var item: DispatchWorkItem? // создаем блок
// создание параллельной  очереди
let concurrentQueue = DispatchQueue(label: "concurrent_queue", attributes: .concurrent)
// создание последовательной   очереди
let serialQueue = DispatchQueue(label: "serial_queue")
