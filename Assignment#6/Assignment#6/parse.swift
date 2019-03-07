//
//  parse.swift
//  Assignment#6
//
//  Created by Checkout User on 3/5/19.
//  Copyright © 2019 Jackson Kurtz. All rights reserved.
//

// import Foundation



func parse(s : Any) -> ExprC {
    switch s {
    case let aint as Int:
        return NumC(num: Float(aint))
    case let anum as Float:
        return NumC(num: anum)
    case let bool as Bool:
        return BoolC(b: bool)
    case let astr as String:
        if astr.prefix(1) == "'" {
            return IdC(s: String(astr.suffix(astr.count - 1)))
        }
        return StringC(str: astr)
    case let lis as [Any]:
        switch lis.first {
        case let fir as String:
            if fir == "'if" && lis.count == 4 {
                return IfC(i: parse(s: lis[1]), t: parse(s: lis[2]), e: parse(s: lis[3]))
            }
            else if (fir == "'+" || fir == "'-" || fir == "'/" || fir == "'*" || fir == "'<=") && lis.count == 3 {
                return AppC(fun: parse(s: fir), args: [parse(s: lis[1]), parse(s: lis[2])])
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
        default:
            let temp = AppC(fun: parse(s: lis[0]), args: lis.dropFirst().map(parse))
            return temp
        }
    default:
        return NullC()
    }
    return NullC()
}

let test_lam1 = [ ["'lam", ["'z", "'y"], ["'+", "'z", "'y"]], ["'+", 9, 14], 98] as [Any]



