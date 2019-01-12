//
//  Tile.swift
//  Loop Over
//
//  Created by Julio Brazil on 20/12/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import SpriteKit

public class Tile: SKSpriteNode {
    var label: String
    var measurementUnit: CGFloat = 0
    var labelNode: SKLabelNode
    
    public init(labeled label: String, withColor color: UIColor = .clear) {
        self.label = label
        
        self.labelNode = SKLabelNode(text: label)
        self.labelNode.fontName = "Avenir-Medium"
        self.labelNode.verticalAlignmentMode = .center
        self.labelNode.horizontalAlignmentMode = .center
        
        super.init(texture: nil, color: color, size: CGSize(width: 0, height: 0))
        
        self.addChild(self.labelNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func move(_ direction: Direction, to newPosition: (Int, Int), completion: @escaping (Tile) -> Void) {
        //TODO: check if moving out of screen
        let position = (CGPoint(x: newPosition.0, y: newPosition.1) * self.measurementUnit) + self.measurementUnit/2
        let action = SKAction.move(to: position, duration: 0.2)
        let completeAction = SKAction.run {
            completion(self)
        }

        self.run(SKAction.sequence([action, completeAction]))
    }
}
