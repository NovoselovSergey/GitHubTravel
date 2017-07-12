//
//  Tickets.swift
//  Travel
//
//  Created by Sergey Novoselov on 12.07.17.
//  Copyright © 2017 Sergey Novoselov. All rights reserved.
//

import Foundation
import RealmSwift

class Tickets: Object {
    dynamic var codeFrom: String = ""
    dynamic var codeWhere: String = ""
    dynamic var value: Int = 0
}
