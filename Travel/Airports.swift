//
//  Airports.swift
//  Travel
//
//  Created by Sergey Novoselov on 24.07.17.
//  Copyright © 2017 Sergey Novoselov. All rights reserved.
//

import Foundation
import RealmSwift

class Airports: Object {
    dynamic var code: String = ""
    dynamic var name: String = ""
    dynamic var time_zone: String = ""
    dynamic var country_code: String = ""
    dynamic var city_code: String = ""
    
}
