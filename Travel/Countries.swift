//
//  Countries.swift
//  Travel
//
//  Created by Sergey Novoselov on 24.07.17.
//  Copyright © 2017 Sergey Novoselov. All rights reserved.
//

import Foundation
import RealmSwift

class Countries: Object {
    dynamic var code: String = ""
    dynamic var name: String = ""
    dynamic var currency: String = ""
}
