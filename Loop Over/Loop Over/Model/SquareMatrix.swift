//
//  Matrix.swift
//  Loop Over
//
//  Created by Julio Brazil on 20/12/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import Foundation

public class SquareMatrix<T: Movable>: CustomStringConvertible where T: Equatable {
    var size: Int
    var elements: [T]
    
    init(ofSize size: Int, withElements elements: [T]) {
        guard elements.count == size**2 else {
            fatalError("Expected the array of elements to have an element count of \(size), got \(elements.count) instead")
        }
        
        self.size = size
        self.elements = elements
    }
    
    convenience init(withElements elements: [T]) {
        let size = Int(sqrt(Double(elements.count)))
        
        guard elements.count == size**2 else {
            fatalError("Expected the array of elements to have an element count of \(size), got \(elements.count) instead")
        }
        
        self.init(ofSize: size, withElements: elements)
    }
    
    subscript (_ column: Int, _ row: Int) -> T {
        get {
            guard row < self.size else { fatalError("Row out of bounds") }
            guard column < self.size else { fatalError("Column out of bounds") }
            
            return self.elements[(self.size * row) + column]
        }
        
        set {
            guard row < self.size else { fatalError("Row out of bounds") }
            guard column < self.size else { fatalError("Column out of bounds") }
            
            self.elements[(self.size * row) + column] = newValue
        }
    }
    
    func getValuesFor(row: Int) -> [T] {
        guard row < self.size else { fatalError("Row out of bounds") }
        
        return Array(self.elements[(row * self.size)..<(row * self.size)+self.size])
    }
    
    func getValuesFor(column: Int) -> [T] {
        guard column < self.size else { fatalError("Column out of bounds") }
        
        var elements = [T]()
        for i in 0..<self.size {
            elements.append(self[column, i])
        }
        return elements
    }
    
    func replaceValuesIn(row: Int, with values: [T]) {
        guard row < self.size else { fatalError("Row out of bounds") }
        guard values.count == self.size else { fatalError("Amount of elements provided differs from matrix size. Expected an element count of \(self.size), got \(values.count) instead") }
        
        self.elements.replaceSubrange((row * self.size)..<(row * self.size)+self.size, with: values)
    }
    
    func replaceValuesIn(column: Int, with values: [T]) {
        guard column < self.size else { fatalError("Row out of bounds") }
        guard values.count == self.size else { fatalError("Amount of elements provided differs from matrix size. Expected an element count of \(self.size), got \(values.count) instead") }
        
        for i in 0..<self.size {
            self[column, i] = values[i]
        }
    }
    
    func rowFor(element: T) -> Int? {
        guard let index = self.elements.firstIndex(of: element) else { return nil }
        let distance = self.elements.startIndex.distance(to: index)
        
        return Int(distance / self.size)
    }
    
    func columnFor(element: T) -> Int? {
        guard let index = self.elements.firstIndex(of: element) else { return nil }
        let distance = self.elements.startIndex.distance(to: index)
        
        return Int(distance % self.size)
    }
    
    func moveElementIn(column: Int, row: Int, to direction: Direction) {
        guard row < self.size else { fatalError("Row out of bounds") }
        guard column < self.size else { fatalError("Column out of bounds") }
        
        var elements = [T]()
        
        switch direction.orientation {
        case .vertical:
            elements = self.getValuesFor(column: column)
        case .horizontal:
            elements = self.getValuesFor(row: row)
        }
        
        switch direction {
        case .right, .down:
            // move last element to the beggining of the array
            elements.insert(elements.removeLast(), at: 0)
        case .left, .up:
            elements.append(elements.removeFirst())
        }
        
        switch direction.orientation {
        case .vertical:
            self.replaceValuesIn(column: column, with: elements)
        case .horizontal:
            self.replaceValuesIn(row: row, with: elements)
        }
        
        elements.forEach { (element) in
            element.move(direction)
        }
    }
    
    func move(element: T, to direction: Direction) {
        guard let column = self.columnFor(element: element) else { fatalError("Couldn't find elements column") }
        guard let row = rowFor(element: element) else { fatalError("Couldn't find elements row") }
        
        self.moveElementIn(column: column, row: row, to: direction)
    }
    
    public var description: String {
        var lines = [String]()
        
        for row in 0..<self.size {
            lines.append(self.getValuesFor(row: row).description)
        }
        
        return lines.joined(separator: "\n")
    }
}
