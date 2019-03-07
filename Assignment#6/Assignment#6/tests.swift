//
//  tests.swift
//  Assignment#6
//
//  Created by Checkout User on 3/6/19.
//  Copyright © 2019 Jackson Kurtz. All rights reserved.
//

import Foundation

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
        return "serializable error"
    }
}

func tests() -> Void {
    print("testing")
    print("t1: ", serializable(v: StringV(str: "hello")), "hello")
    print("t2: ", serializable(v: BoolV(bool: true)) == "true")
    print("t3: ", serializable(v: BoolV(bool: false)) == "false")
    print("t4: ", serializable(v: ClosV(args: ["test"], body: StringC(str: "test"), env: Env(bindings: []))) == "closure")
    print("t5: ", serializable(v: NullV()) == "null")
    print("t6: ", serializable(v: NumV(num: 42)) == "42.0")

}

