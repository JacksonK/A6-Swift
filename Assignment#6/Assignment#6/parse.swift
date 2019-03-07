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


func parse(s : Any) -> ExprC {
    //print("parse s=", s)
    switch s {
    case let aint as Int:
        //print("int: ", aint)
        return NumC(num: Float(aint))
    case let anum as Float:
        //print("float: ", anum)
        return NumC(num: anum)
    case let bool as Bool:
        //print("bool: ", bool)
        return BoolC(b: bool)
    case let astr as String:
        if astr.prefix(1) == "'" {
            //print("idc: ", astr.suffix(astr.count - 1))
            return IdC(s: String(astr.suffix(astr.count - 1)))
        }
        //print("str: ", astr)
        return StringC(str: astr)
    case let lis as [Any]:
        switch lis.first {
        case let fir as String:
            if fir == "'if" && lis.count == 4 {
                return IfC(i: parse(s: lis[1]), t: parse(s: lis[2]), e: parse(s: lis[3]))
            }
            else if fir == "'+" && lis.count == 3 {
                //print("in plus case")
                //print("left: ", lis[1], "right : ", lis[2])
                return PlusC(left: parse(s: lis[1]), right: parse(s: lis[2]))
            }
            else if fir == "'-" && lis.count == 3 {
                return MinusC(left: parse(s: lis[1]), right: parse(s: lis[2]))
            }
            else if fir == "'*" && lis.count == 3 {
                return MultC(left: parse(s: lis[1]), right: parse(s: lis[2]))
            }
            else if fir == "'/" && lis.count == 3 {
                return DivC(left: parse(s: lis[1]), right: parse(s: lis[2]))
            }
            else if fir == "'lam" && lis.count == 3 {
                let l = lis[1]
                switch l {
                case let l as [String]:
                    //print("lamc: ", l, lis)
                    //return LamC(args: l, body: parse(s: lis.dropFirst().map(parse)))
                    return LamC(args: l, body: parse(s: lis[2]))
                default:
                    print("ERROR: LAM NEEDS LIST OF IDS")
                    return NullC()
                }
            }
            
            //[ ["'lam", ["'z", "'y"], ["'+", "'z", "'y"]], ["'+", 9, 14], 98]
            //else if fir == "'var" && lis.count ==
        //if fir == "'lam" &&
        default:
            let temp = AppC(fun: parse(s: lis[0]), args: lis.dropFirst().map(parse))
            //print("fun ", lis[0])
            //print("args ", lis.dropFirst())
            return temp//args: lis.dropFirst().map(parse))
        }
        //print("lis: ", lis)
        //lis.map(parse)
    default:
        //print("no match found")
        return NullC()
    }
    //print("returning NullC")
    //print("s = ", s)
    return NullC()
}

let test_lam1 = [ ["'lam", ["'z", "'y"], ["'+", "'z", "'y"]], ["'+", 9, 14], 98] as [Any]



