//
//  Value.swift
//  Assignment#6
//
//  Created by Jackson Kurtz on 3/5/19.
//  Copyright © 2019 Jackson Kurtz. All rights reserved.
//

import Foundation

class Value{}

class NumV: Value {
    var num: Float
    
    init(num: Float) {
        self.num = num
    }
}

class StringV: Value {
    var str: String
    
    init(str: String) {
        self.str = str
    }
}
