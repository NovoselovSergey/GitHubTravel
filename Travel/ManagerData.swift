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

class ManagerData {
    func loadJSON() {
        let realm = try! Realm()
        
        let url = "http://api.travelpayouts.com/v2/prices/latest?origin=LON&currency=rub&destination=TIV&period_type=year&page=1&limit=30&show_to_affiliates=true&sorting=price&trip_class=0&token="
        var destination: String = ""
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("City: \(json["data"]["destination"].stringValue)")
                for (_, subJson) in json["data"] {
                    let ticket = Tickets()
                    ticket.codeFrom = subJson["origin"].stringValue
                    ticket.codeWhere = subJson["destination"].stringValue
                    ticket.value = subJson["value"].intValue
                    print(ticket)
                    
                    try! realm.write {
                        realm.add(ticket)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
