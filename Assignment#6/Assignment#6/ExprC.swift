//
//  ExprC.swift
//  Assignment#6
//
//  Created by Jackson Kurtz on 3/5/19.
//  Copyright © 2019 Jackson Kurtz. All rights reserved.
//

import Foundation

class ExprC {}

class NumC: ExprC {
    var num: Float
    
    init(num: Float) {
        self.num = num
    }
}

class StringC: ExprC {
    var str: String
    
    init(str: String) {
        self.str = str
    }
}

class PlusC: ExprC {
    var left: ExprC
    var right: ExprC
    
    init(left: ExprC, right: ExprC) {
        self.left = left
        self.right = right
    }
}