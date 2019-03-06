//
//  main.swift
//  Assignment#6
//
//  Created by Jackson Kurtz on 3/3/19.
//  Copyright © 2019 Jackson Kurtz. All rights reserved.
//

import Foundation


func interp( exp: ExprC ) -> Value {
    switch exp {
    case let exp_num as NumC:
        print( exp_num.num )
        return NumV( num: exp_num.num )
    case let exp_str as StringC:
        print( exp_str.str )
        return StringV( str: exp_str.str )
    case let exp_plusC as PlusC:
        let left = interp(exp: exp_plusC.left) as! NumV
        let right = interp(exp: exp_plusC.right) as! NumV
        let result = left.num + right.num
        print( result )
        return NumV(num: result)
    default:
        print("type not found")
        return Value()
    }
}

//interp( exp: NumC(num: 10))
//interp( exp: StringC(str: "test string"))

//interp( exp: StringC(str: "test string"))

// (2 + 3) + 5
//let interp_result = interp( exp: PlusC(left: PlusC(left: NumC(num: 2), right: NumC(num: 3)), right: NumC(num: 5))) as! NumV
//print("result: ", interp_result.num)
