//
//  parse.swift
//  Assignment#6
//
//  Created by Checkout User on 3/5/19.
//  Copyright © 2019 Jackson Kurtz. All rights reserved.
//

// import Foundation
//let sexp = ["'var", ["'z","'=", 14], ["'+", "'z", true]] as [Any]
//let testif = ["'if", true, 1, 2] as [Any]
//
//let testlam = ["'lam", ["'x"], ["'x", 1, 2]] as [Any]
//
//
//class NullC: ExprC {
//}
//class IdC: ExprC {
//    var s: String
//    init(s: String) {
//        self.s = s
//    }
//}
//
//class ExprC {
//    var description : String {
//        return "ExprC"
//    }
//}
//
//class NumC: ExprC {
//    var num: Float
//
//    init(num: Float) {
//        self.num = num
//    }
//    override var description: String {
//        return "\(self.num)"
//    }
//}
//
//class StringC: ExprC {
//    var str: String
//
//    init(str: String) {
//        self.str = str
//    }
//    override var description: String {
//        return self.str
//    }
//}
//
//class IfC: ExprC {
//    var i: BoolC
//    var t: ExprC
//    var e: ExprC
//    init(i : ExprC, t : ExprC, e : ExprC) {
//        if let obj = i as? BoolC {
//            self.i = obj
//        }
//        else {
//            print("ERROR: FIRST VALUE IN IF MUST BE BOOLEAN")
//            self.i = BoolC(b: false)
//
//        }
//        self.t = t
//        self.e = e
//    }
//    override var description: String {
//        return "IfC \(self.i.description) \(self.t.description) \(self.e.description)"
//    }
//}
//class LamC: ExprC {
//    var lis: [ExprC]
//    var body: ExprC
//    init(lis : [ExprC], body : ExprC) {
//        self.lis = lis
//        self.body = body
//    }
//    override var description: String {
//        return "(lam \(self.lis) \(self.body.description))"
//    }
//}
//class appC: ExprC {
//    var fname : IdC
//    var args: [ExprC]
//    init(fname : ExprC, args : [ExprC]) {
//        if let fn = fname as? IdC {
//            self.fname = fn
//        }
//        else {
//            print("ERROR: FUNCTION NAME MUST BE IDC")
//            self.fname = IdC(s: "nope")
//        }
//        self.args = args
//    }
//    override var description: String {
//        return "(appC \(self.fname.description) \(self.args))"
//    }
//
//}
//class BoolC: ExprC {
//    var b: Bool
//    init(b: Bool) {
//        self.b = b
//    }
//    override var description: String {
//        return String(self.b)
//    }
//
//}
//
//
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
                return IfC(i: parse(s: lis[1]), t: parse(s: lis[2]), e: parse(s: lis[3]))
            }
            else if fir == "'lam" && lis.count == 3 {
                let l = lis[1]
                switch l {
                case let l as [String]:
                    return LamC(args: l, body: parse(s: lis[2]))
                default:
                    print("ERROR: LAM NEEDS LIST OF IDS")
                    return NullC()
                }
            }
            //else if fir == "'var" && lis.count ==
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
