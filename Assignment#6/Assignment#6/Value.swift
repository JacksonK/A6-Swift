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

class NullV: Value {
    
}

class BoolV: Value {
    var bool: Bool
    init(bool: Bool) {
        self.bool = bool
    }
}

class StringV: Value {
    var str: String
    
    init(str: String) {
        self.str = str
    }
}

class ClosV: Value {
    var args: [String]
    var body: ExprC
    var env: Env
    
    init(args: [String], body: ExprC, env: Env) {
        self.args = args
        self.body = body
        self.env = env
    }
}
