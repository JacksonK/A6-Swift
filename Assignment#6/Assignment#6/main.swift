//
//  main.swift
//  Assignment#6
//
//  Created by Jackson Kurtz on 3/3/19.
//  Copyright © 2019 Jackson Kurtz. All rights reserved.
//

import Foundation


class ExprC {
}

class NumC: ExprC {
    var num: Float
    
    init(num: Float) {
        self.num = num
    }
}

class StringC: ExprC {
    var str: String
    
    init(str: String) {
        self.str = str
    }
}

func interp( exp: ExprC ) {
    switch exp {
    case let exp_num as NumC:
        print( exp_num.num )
    case let exp_str as StringC:
        print( exp_str.str )
    default:
        print("type not found")
    }
}

interp( exp: NumC(num: 10))
interp( exp: StringC(str: "test string"))


