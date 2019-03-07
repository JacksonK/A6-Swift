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


func numPlus (left: Value, right: Value) -> Value {
    switch left {
    case let left_num as NumV:
        switch right {
        case let right_num as NumV:
            let x = left_num.num + right_num.num
            return NumV(num: x)
        default:
            return NullV()
        }
    default:
        return NullV()
    }
}

func numMinus (left: Value, right: Value) -> Value {
    switch left {
    case let left_num as NumV:
        switch right {
        case let right_num as NumV:
            let x = left_num.num - right_num.num
            return NumV(num: x)
        default:
            return NullV()
        }
    default:
        return NullV()
    }
}

func numMult (left: Value, right: Value) -> Value {
    switch left {
    case let left_num as NumV:
        switch right {
        case let right_num as NumV:
            let x = left_num.num * right_num.num
            return NumV(num: x)
        default:
            return NullV()
        }
    default:
        return NullV()
    }
}

func numDivide (left: Value, right: Value) -> Value {
    switch left {
    case let left_num as NumV:
        switch right {
        case let right_num as NumV:
            if right_num.num != 0.0 {
                let x = left_num.num / right_num.num
                return NumV(num: x)
            }
            else {
                return NullV()
            }
        default:
            return NullV()
        }
    default:
        return NullV()
    }
}

func numlessThanOrEqual (left: Value, right: Value) -> Value {
    switch left {
    case let left_num as NumV:
        switch right {
        case let right_num as NumV:
            let x = left_num.num <= right_num.num
            return BoolV(bool: x)
        default:
            return NullV()
        }
    default:
        return NullV()
    }
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
            case let fprim as PrimV:
                return fprim.op(interp(exp: exp_app.args[0], env: env), interp(exp: exp_app.args[1], env: env))
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
    default:
        return Value()
    }
}

//test cases
let testBindings = [Binding(name: "+", val: PrimV(op: numPlus)),
                    Binding(name: "-", val: PrimV(op: numMinus)),
                    Binding(name: "/", val: PrimV(op: numDivide)),
                    Binding(name: "*", val: PrimV(op: numMult)),
                    Binding(name: "<=", val: PrimV(op: numlessThanOrEqual))]
let testEnv = Env(bindings: testBindings)

tests()
