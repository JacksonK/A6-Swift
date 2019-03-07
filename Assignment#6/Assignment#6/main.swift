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
    case let exp_bool as BoolC:
        return BoolV(bool: exp_bool.b)
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
    case let exp_if as IfC:
        let if_case = interp(exp: exp_if.i, env: env) as! BoolV
        if if_case.bool == true {
            return interp(exp: exp_if.t, env: env)
        }
        else {
            return interp(exp: exp_if.e, env:env)
        }
    case let exp_id as IdC:
        let found_binding = env.bindings.first(where:{ $0.name == exp_id.s})
        return found_binding!.val
    case let exp_plusC as PlusC:
        let left = interp(exp: exp_plusC.left, env: env) as! NumV
        let right = interp(exp: exp_plusC.right, env: env) as! NumV
        let result = left.num + right.num
        return NumV(num: result)
    case let exp_minusC as MinusC:
        let left = interp(exp: exp_minusC.left, env: env) as! NumV
        let right = interp(exp: exp_minusC.right, env: env) as! NumV
        let result = left.num - right.num
        return NumV(num: result)
    case let exp_multC as MultC:
        let left = interp(exp: exp_multC.left, env: env) as! NumV
        let right = interp(exp: exp_multC.right, env: env) as! NumV
        let result = left.num * right.num
        return NumV(num: result)
    case let exp_divC as DivC:
        let left = interp(exp: exp_divC.left, env: env) as! NumV
        let right = interp(exp: exp_divC.right, env: env) as! NumV
        if right.num == 0 {
            return NullV()
        }
        else {
            let result = left.num / right.num
            return NumV(num: result)
        }
    case let exp_leequalC as leequalC:
        let left = interp(exp: exp_leequalC.right, env: env) as! NumV
        let right = interp(exp: exp_leequalC.left, env: env) as! NumV
        if left.num <= right.num {
            return BoolV(bool: true)
        }
        else {
            return BoolV(bool: false)
        }
        
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

if let testIf = interp(exp: IfC(i: BoolC(b: true), t: NumC(num: 5), e: NumC(num: 6)), env: testEnv) as? NumV {
    print("result #3: if statement ", testIf.num)
}
else {
    print("Failed If Statement")
}

if let testIf = interp(exp: IfC(i: BoolC(b: false), t: NumC(num: 5), e: NumC(num: 6)), env: testEnv) as? NumV {
    print("result #4: if statement ", testIf.num)
}
else {
    print("Failed If Statement")
}

let testif = ["'if", true, 1, 2] as [Any]
if let if_result = interp(exp: parse(s: testif), env: testEnv) as? NumV {
    print("result #5: if statement ", if_result.num)
}
else {
    print("Failed test #5")
}






