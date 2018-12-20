//
//  Extensions.swift
//  Loop Over
//
//  Created by Julio Brazil on 20/12/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import SpriteKit

infix operator **: MultiplicationPrecedence

func ** (num: Double, power: Double) -> Double{
    return pow(num, power)
}

func ** (num: Int, power: Int) -> Int{
    return Int(Double(num)**Double(power))
}

extension CGPoint {
    static func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    
    static func +(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x + rhs, y: lhs.y + rhs)
    }
}
