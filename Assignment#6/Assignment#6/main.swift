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
    //print("in interp")
    //print("exp ",exp)
    switch exp {
    case let exp_num as NumC:
        return NumV( num: exp_num.num )
    case let exp_bool as BoolC:
        return BoolV(bool: exp_bool.b)
    case let exp_str as StringC:
        return StringV( str: exp_str.str )
    case let exp_app as AppC:
        //print("in AppC")
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
        //print("IdC: ", exp_id.description)
        //print("found_binding=", found_binding)
        //print("env = ", env)
        return found_binding!.val
    case let exp_plusC as PlusC:
        let left = interp(exp: exp_plusC.left, env: env) as! NumV
        let right = interp(exp: exp_plusC.right, env: env) as! NumV
        let result = left.num + right.num
        //print("in PlusC adding", result)
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
        //print("returning value for ", exp)
        return Value()
    }
}

//test cases
let testBindings = [Binding(name: "t", val: NumV(num: 2))]
let testEnv = Env(bindings: testBindings)
//print( interp(exp: IdC(s: "t"), env: testEnv))
//
//let testApp = AppC(fun: LamC(args: ["t"], body: IdC(s: "t")), args: [NumC(num: 2)])
//if let res2 = interp(exp: testApp, env: testEnv) as? NumV {
//    print("result#2: ", res2.num )
//}
//else {
//    print("result#2: FAILED")
//}
//
//if let testIf = interp(exp: IfC(i: BoolC(b: true), t: NumC(num: 5), e: NumC(num: 6)), env: testEnv) as? NumV {
//    print("result #3: if statement ", testIf.num)
//}
//else {
//    print("Failed If Statement")
//}
//
//if let testIf = interp(exp: IfC(i: BoolC(b: false), t: NumC(num: 5), e: NumC(num: 6)), env: testEnv) as? NumV {
//    print("result #4: if statement ", testIf.num)
//}
//else {
//    print("Failed If Statement #4")
//}
//
//let testif = ["'if", true, 1, 2] as [Any]
//if let if_result = interp(exp: parse(s: testif), env: testEnv) as? NumV {
//    print("result #5: if statement ", if_result.num)
//}
//else {
//    print("Failed test #5")
//}
//
let test_lam = [ ["'lam", ["'z", "'y"], ["'+", "'z", "'y"]], ["'+", 9, 14], 98] as [Any]
//if let lam_result = interp(exp: parse(s: test_lam), env: testEnv) as? NumV {
//    print("result #6: if statement ", lam_result.num)
//}
//else {
//    print("Failed test #6")
//}

//print("test lam ", interp(exp: parse(s: test_lam), env: testEnv))
//print("test lam", parse(s: test_lam))
//if let lam_result = parse(s: test_lam)  as? AppC {
//    print("parsed = ", lam_result.description)
//    //print("args ", lam_result.args.description)
//    //print("func ", lam_result.fun.description)
//    
//}
//else {
//    print("Failed test #6")
//}
//if let lam_result = interp(exp: parse(s: test_lam), env: testEnv)  as? NumV {
//    print(lam_result.num)
//    //print("args ", lam_result.args.description)
//    //print("func ", lam_result.fun.description)
//
//}
//print("interp", interp(exp: parse(s: test_lam), env: testEnv))

let test_plus = ["'+", 1, 2] as [Any]
let test_lam2 = ["'lam", ["'z", "'y"], ["'+", "'z", "'y"]] as [Any]
//let x = interp(exp: parse(s: test_lam2), env: testEnv)
//let x = parse(s: test_lam)
//print(x)
//print("X ", x.num)
//print("interp lam ", interp(exp: parse(s: test_lam), env: testEnv))

//let pokeMirror = Mirror(reflecting: x)
//let properties = pokeMirror.children
//print("here")
//for property in properties {
//    print("prop")
//    print("\(property.label!) = \(property.value)")
//
//}

//print("test lam parse end", parse(s: ["'lam", ["'x"], ["'x", 1, 2]] as [Any]))
//let x = parse(s: ["'+", 1, 2])
//print(x)

//print(interp(exp: AppC(fun: LamC(args: ["'z", "'y"], body: PlusC(left: IdC(s: "'z"), right: IdC(s: "'y"))), args: [PlusC(left: NumC(num: 9), right: NumC(num: 14)), NumC(num: 98)]), env: testEnv)) 
tests()
