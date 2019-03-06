//
//  parse.swift
//  Assignment#6
//
//  Created by Checkout User on 3/5/19.
//  Copyright © 2019 Jackson Kurtz. All rights reserved.
//

import Foundation
let sexp = ["'var", ["'z","'=", 14], ["'+", "'z", true]] as [Any]
let testif = ["'if", true, 1, 2] as [Any]

class NullC: ExprC {
}
class IdC: ExprC {
    var s: String
    init(s: String) {
        self.s = s
    }
}
class IfC: ExprC {
    var i: BoolC
    var t: ExprC
    var e: ExprC
    init(i : ExprC, t : ExprC, e : ExprC) {
        if i is BoolC {
            self.i = BoolC(i)
        }
        self.t = t
        self.e = e
    }
}
class LamC: ExprC {
    var lis: [IdC]
    var body: ExprC
    init(lis : [IdC], body : ExprC) {
        self.lis = lis
        self.body = body
    }
}
class BoolC: ExprC {
    var b: Bool
    init(b: Bool) {
        self.b = b
    }
}


func parse(s : Any) -> ExprC {
    switch s {
    case let aint as Int:
        print("int: ", aint)
        return NumC(num: Float(aint))
    case let anum as Float:
        print("float: ", anum)
        return NumC(num: anum)
    case let bool as Bool:
        print("bool: ", bool)
        return BoolC(b: bool)
    case let astr as String:
        if astr.prefix(1) == "'" {
            print("idc: ", astr.suffix(astr.count - 1))
            return IdC(s: String(astr.suffix(astr.count - 1)))
        }
        print("str: ", astr)
        return StringC(str: astr)
    case let lis as [Any]:
        switch lis.first {
        case let fir as String:
            if fir == "'if" && lis.count == 4 {
                var iff = parse(s: lis[1])
                return IfC(i: parse(s: lis[1]), t: parse(s: lis[2]), e: parse(s: lis[3]))
            }
            //if fir == "'lam" &&
        default:
            return NullC()
        }

        print("lis: ", lis)
        lis.map(parse)
    default:
        print("no match found")
        return NullC()
    }
    return NullC()
}

//    switch s {
//    case let sexp_num as Float:
//        print( "its a num" )
//        return NumC(num: sexp_num)
//    case let sexp_str as String:
//        print( "its a string" )
//        return StringC(str: sexp_str)
//    default:
//        print("type not found")
//    }
//}

