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


class MinusC: ExprC {
    var left: ExprC
    var right: ExprC
    
    init(left: ExprC, right: ExprC) {
        self.left = left
        self.right = right
    }
}


class MultC: ExprC {
    var left: ExprC
    var right: ExprC
    
    init(left: ExprC, right: ExprC) {
        self.left = left
        self.right = right
    }
}


class DivC: ExprC {
    var left: ExprC
    var right: ExprC
    
    init(left: ExprC, right: ExprC) {
        self.left = left
        self.right = right
    }
}


class leequalC: ExprC {
    var left: ExprC
    var right: ExprC
    
    init(left: ExprC, right: ExprC) {
        self.left = left
        self.right = right
    }
}


class AppC: ExprC {
    var fun: ExprC
    var args: [ExprC]
    
    init(fun: ExprC, args: [ExprC]) {
        self.fun = fun
        self.args = args
    }
}

class LamC: ExprC {
    var args: [String]
    var body: ExprC
    
    init(args: [String], body: ExprC) {
        self.args = args
        self.body = body
    }
}

class IdC: ExprC {
    var s: String
    init(s: String) {
        self.s = s
    }
}


class BoolC: ExprC {
    var b: Bool
    init(b: Bool) {
        self.b = b
    }
//    override var description: String {
//        return String(self.b)
//    }
    
}

class NullC: ExprC {
    
}



class IfC: ExprC {
    var i: BoolC
    var t: ExprC
    var e: ExprC
    init(i : ExprC, t : ExprC, e : ExprC) {
        if let obj = i as? BoolC {
            self.i = obj
        }
        else {
            print("ERROR: FIRST VALUE IN IF MUST BE BOOLEAN")
            self.i = BoolC(b: false)
            
        }
        self.t = t
        self.e = e
    }
//    override var description: String {
//        return "IfC \(self.i.description) \(self.t.description) \(self.e.description)"
//    }
}

