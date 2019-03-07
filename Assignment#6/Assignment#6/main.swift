//
//  main.swift
//  Assignment#6
//
//  Created by Jackson Kurtz on 3/3/19.
//  Copyright © 2019 Jackson Kurtz. All rights reserved.
//

import Foundation

func bindArgs(args: [Value], vars: [String], env: Env ) -> Env {
    let newEnv = env
    for index in 0...args.count-1 {
        newEnv.bindings.append(Binding(name: vars[index], val: args[index]))
    }
    return newEnv
}

func interp( exp: ExprC, env: Env ) -> Value {
    switch exp {
    case let exp_num as NumC:
        return NumV( num: exp_num.num )
    case let exp_str as StringC:
        return StringV( str: exp_str.str )
    case let exp_app as AppC:
        let f_value = interp(exp: exp_app.fun, env: env)
        switch f_value{
            case let fval as ClosV:
                var closArgsList = [Value]()
                for index in 0..<exp_app.args.count {
                    closArgsList.append(interp(exp: exp_app.args[index], env: env))
                }
                return interp(exp: fval.body, env: bindArgs(args: closArgsList, vars: fval.args, env: fval.env) )
            default:
                return Value()
        }        
    case let exp_lam as LamC:
        return ClosV(args: exp_lam.args, body: exp_lam.body, env: env)
    case let exp_id as IdC:
        let found_binding = env.bindings.first(where:{ $0.name == exp_id.s})
        return found_binding!.val
    case let exp_plusC as PlusC:
        let left = interp(exp: exp_plusC.left, env: env) as! NumV
        let right = interp(exp: exp_plusC.right, env: env) as! NumV
        let result = left.num + right.num
        return NumV(num: result)
    default:
        return Value()
    }
}

//test cases
let testBindings = [Binding(name: "t", val: NumV(num: 2))]
let testEnv = Env(bindings: testBindings)
print( interp(exp: IdC(s: "t"), env: testEnv))

let testApp = AppC(fun: LamC(args: ["t"], body: IdC(s: "t")), args: [NumC(num: 2)])
if let res2 = interp(exp: testApp, env: testEnv) as? NumV {
    print("result#2: ", res2.num )
}
else {
    print("result#2: FAILED")
}

