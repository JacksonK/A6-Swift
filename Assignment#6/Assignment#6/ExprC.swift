//
//  ExprC.swift
//  Assignment#6
//
//  Created by Jackson Kurtz on 3/5/19.
//  Copyright © 2019 Jackson Kurtz. All rights reserved.
//

import Foundation

class ExprC {
    var description : String {
        return "ExprC"
    }
}

class NumC: ExprC {
    var num: Float
    
    init(num: Float) {
        self.num = num
    }
    
    override var description: String {
        return "\(self.num)"
    }
}

class StringC: ExprC {
    var str: String
    
    init(str: String) {
        self.str = str
    }
    
    override var description: String {
        return self.str
        }
}

class PlusC: ExprC {
    var left: ExprC
    var right: ExprC
    
    init(left: ExprC, right: ExprC) {
        self.left = left
        self.right = right
    }
    
    override var description: String {
        return "PlusC `\(self.left.description) `\(self.right.description)"
    }
}


class MinusC: ExprC {
    var left: ExprC
    var right: ExprC
    
    init(left: ExprC, right: ExprC) {
        self.left = left
        self.right = right
    }
    
    override var description: String {
        return "MinusC \(self.left.description) \(self.right.description)"
    }
}


class MultC: ExprC {
    var left: ExprC
    var right: ExprC
    
    init(left: ExprC, right: ExprC) {
        self.left = left
        self.right = right
    }
    
    override var description: String {
        return "MultC \(self.left.description) \(self.right.description)"
    }
}


class DivC: ExprC {
    var left: ExprC
    var right: ExprC
    
    init(left: ExprC, right: ExprC) {
        self.left = left
        self.right = right
    }
    
    override var description: String {
        return "DivC \(self.left.description) \(self.right.description)"
    }
}


class leequalC: ExprC {
    var left: ExprC
    var right: ExprC
    
    init(left: ExprC, right: ExprC) {
        self.left = left
        self.right = right
    }
    
    override var description: String {
        return "leequalC \(self.left.description) \(self.right.description)"
    }
}


class AppC: ExprC {
    var fun: ExprC
    var args: [ExprC]
    
    init(fun: ExprC, args: [ExprC]) {
        self.fun = fun
        self.args = args
    }
    
    override var description: String {
        return "AppC \(self.fun.description) \(self.args.description)"
    }
}

class LamC: ExprC {
    var args: [String]
    var body: ExprC
    
    init(args: [String], body: ExprC) {
        self.args = args
        self.body = body
    }
    
    override var description: String {
        return "LamC \(self.args) \(self.body.description)"
    }
}

class IdC: ExprC {
    var s: String
    init(s: String) {
        self.s = s
    }
    
    override var description: String {
        return "IdC \(self.s)"
        
    }
}


class BoolC: ExprC {
    var b: Bool
    init(b: Bool) {
        self.b = b
    }
    override var description: String {
        return String(self.b)
    }
    
}

class NullC: ExprC {
    override var description: String {
        return "NullC"
    }
    
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
    
    override var description: String {
        return "IfC \(self.i.description) \(self.t.description) \(self.e.description)"
        
    }
}

