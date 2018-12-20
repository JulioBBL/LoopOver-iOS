//
//  Direction.swift
//  Loop Over
//
//  Created by Julio Brazil on 20/12/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import SpriteKit

public enum Direction: String {
    case up, right, down, left
    
    /// CGPoint vactorial representation of the direction value.
    public var vector: CGPoint {
        get {
            switch self {
            case .up:
                return CGPoint(x: 0, y: 1)
            case .right:
                return CGPoint(x: 1, y: 0)
            case .down:
                return CGPoint(x: 0, y: -1)
            case .left:
                return CGPoint(x: -1, y: 0)
            }
        }
    }
    
    /// Describes what orientation the direction is in.
    public var orientation: Orientation {
        get {
            switch self {
            case .up, .down:
                return .vertical
            case .right, .left:
                return .horizontal
            }
        }
    }
    
    /// Returns the oposite direction.
    ///
    /// - Parameter rhs: The current direction.
    /// - Returns: The oposite direction to the one provided.
    static prefix func !(_ rhs: Direction) -> Direction {
        switch rhs {
        case .up:
            return .down
        case .right:
            return .left
        case .down:
            return .up
        case .left:
            return .right
        }
    }
}

public enum Orientation: String {
    case vertical, horizontal
}
