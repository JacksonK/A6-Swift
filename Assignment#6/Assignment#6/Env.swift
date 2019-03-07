//
//  Env.swift
//  Assignment#6
//
//  Created by Jackson Kurtz on 3/5/19.
//  Copyright © 2019 Jackson Kurtz. All rights reserved.
//

import Foundation
class Env {
    var bindings: [Binding]
    init(bindings: [Binding]) {
        self.bindings = bindings
    }
}

class Binding {
    var name: String
    var val: Value
    init(name: String, val: Value) {
        self.name = name
        self.val = val
    }
}
