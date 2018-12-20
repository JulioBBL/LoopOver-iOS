//
//  GameScene.swift
//  Loop Over
//
//  Created by Julio Brazil on 20/12/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import SpriteKit
import GameplayKit

//TODO: start counting time when the first interaction is made (touchesbegan)
//TODo: flip matrix y axis

class GameScene: SKScene {
    var measurementUnit: CGFloat = 0
    
    var matrix: SquareMatrix<Tile>!
    var tiles = [Tile]()
    
    var isAnimating = false
    
    var touchedTile: Tile?
    var lastKnownTilePosition = CGPoint.zero
    
    override func sceneDidLoad() {
        
    }
    
    func setupGameWith(matrixSize: Int) {
        self.measurementUnit = self.size.width / CGFloat(matrixSize)
        self.setupTiles(totaling: matrixSize**2)
        
        self.matrix = SquareMatrix<Tile>(ofSize: matrixSize, withElements: self.tiles)
        
        self.tiles.forEach { (tile) in
            let x = self.matrix.columnFor(element: tile) ?? 0
            let y = self.matrix.rowFor(element: tile) ?? 0
            
            tile.move(.up, to: (x,y)){_ in}
        }
    }
    
    func setupTiles(totaling amount: Int) {
        for i in 0..<amount {
            let tile = Tile(labeled: "\(i)", withColor: .gray)
            tile.measurementUnit = self.measurementUnit
            
            tile.size = CGSize(width: self.measurementUnit, height: self.measurementUnit)
            
            self.tiles.append(tile)
            self.addChild(tile)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let position = touch.location(in: self)
        
        if let tile = self.nodes(at: position).first as? Tile {
            self.touchedTile = tile
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let touchedTile = self.touchedTile else { return }
        
        let position = touch.location(in: self)
        let halfMeasure = self.measurementUnit/2
        
        if !self.isAnimating, position.x > touchedTile.position.x + halfMeasure {
            self.isAnimating = true
            self.matrix.move(element: touchedTile, to: .right) { tile in
                self.lastKnownTilePosition = tile.position
                self.isAnimating = false
            }
        } else if !self.isAnimating, position.x < touchedTile.position.x - halfMeasure {
            self.isAnimating = true
            self.matrix.move(element: touchedTile, to: .left) { tile in
                self.lastKnownTilePosition = tile.position
                self.isAnimating = false
            }
        } else if !self.isAnimating, position.y > touchedTile.position.y + halfMeasure {
            self.isAnimating = true
            self.matrix.move(element: touchedTile, to: .down) { tile in
                self.lastKnownTilePosition = tile.position
                self.isAnimating = false
            }
        } else if !self.isAnimating, position.y < touchedTile.position.y - halfMeasure {
            self.isAnimating = true
            self.matrix.move(element: touchedTile, to: .up) { tile in
                self.lastKnownTilePosition = tile.position
                self.isAnimating = false
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchedTile = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        //TODO: count elapsed time
    }
}
