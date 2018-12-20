//
//  Movable.swift
//  Loop Over
//
//  Created by Julio Brazil on 20/12/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import SpriteKit

public protocol Movable {
    func move(_ direction: Direction, to newPosition: (Int, Int), completion: @escaping (Tile) -> Void)
}

extension Int: Movable {
    public func move(_ direction: Direction, to newPosition: (Int, Int), completion: @escaping (Tile) -> Void) {
        print("moved \(self) \(direction.rawValue) to \(newPosition)")
    }
}
