//
//  EarthEntity.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 25.11.24.
//

import Foundation
import GameplayKit
import SpriteKit

class EarthEntity: GKEntity {
    init(scene: SKScene) {
        super.init()
    
        let shape = SKShapeNode(rectOf: .init(width: 256, height: 16))
        shape.lineWidth = 0
        shape.fillColor = .green
        shape.position = .init(x: 128, y: 8)
        self.addComponent(ShapeComponent(shape: shape, scene: scene))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
