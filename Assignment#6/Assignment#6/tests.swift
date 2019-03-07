//
//  tests.swift
//  Assignment#6
//
//  Created by Checkout User on 3/6/19.
//  Copyright © 2019 Jackson Kurtz. All rights reserved.
//

import Foundation

func topinterp(sexp : [Any]) -> String {
    return serializable(v: (interp(exp: parse(s: sexp), env: testEnv)))
}

func serializable(v : Value) -> String {
    switch v {
    case let s as StringV:
        return s.str
    case let n as NumV:
        return String(n.num)
    case is NullV:
        return "null"
    case let b as BoolV:
        return String(b.bool)
    case is ClosV:
        return "closure"
    default:
        return "serializable error: \(v)"
    }
}


func tests() -> Void {
    print("testing")
    print("t1: ", serializable(v: StringV(str: "hello")) == "hello")
    print("t2: ", serializable(v: BoolV(bool: true)) == "true")
    print("t3: ", serializable(v: BoolV(bool: false)) == "false")
    print("t4: ", serializable(v: ClosV(args: ["test"], body: StringC(str: "test"), env: Env(bindings: []))) == "closure")
    print("t5: ", serializable(v: NullV()) == "null")
    print("t6: ", serializable(v: NumV(num: 42)) == "42.0")
    print("t7: ", topinterp(sexp: ["'+", 1, 2]) == "3.0")
    print("t8: ", topinterp(sexp: ["'-", 1, 2]) == "-1.0")
    print("t9: ", topinterp(sexp: ["'/", 1, 2]) == "0.5")
    print("t9: ", topinterp(sexp: ["'/", 1, 0]) == "null") // Should return null because it is trying to divide by zero
    print("t10: ", topinterp(sexp: ["'*", 1, 2]) == "2.0")
    print("t10: ", topinterp(sexp: ["'*", 2, ["'+", 1, 2]]) == "6.0")
    print("t11: ", topinterp(sexp: ["'if", true, ["'+", 1, 2], ["'-", 1, 2]]) == "3.0")
    print("t12: ", topinterp(sexp: ["'if", false, ["'+", 1, 2], ["'-", 1, 2]]) == "-1.0")
    print("t13: ", serializable(v: interp(exp: AppC(fun: LamC(args: ["'z", "'y"], body: PlusC(left: IdC(s: "'z"), right: IdC(s: "'y"))), args: [PlusC(left: NumC(num: 9), right: NumC(num: 14)), NumC(num: 98)]), env: testEnv)) == "121.0")
    print("t14: ", topinterp(sexp: ["'lam", ["'z", "'y"], ["'+", "'z", "'y"]]) == "closure")
}

