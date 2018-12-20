//
//  Movable.swift
//  Loop Over
//
//  Created by Julio Brazil on 20/12/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import Foundation

public protocol Movable {
    func move(_ direction: Direction)
}

extension Int: Movable {
    public func move(_ direction: Direction) {
        print("moved \(self) \(direction.rawValue)")
    }
}
