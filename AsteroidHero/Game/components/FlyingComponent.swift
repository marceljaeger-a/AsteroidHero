//
//  FlyingComponent.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 25.11.24.
//

import Foundation
import GameplayKit
import SpriteKit

class FlyingComponent: GKComponent {
    var movementVector: CGVector
    var movementSpeedFactor: CGFloat
    
    var node: SKNode? {
        self.entity?.component(ofType: ShapeComponent.self)?.shape
    }
    
    init(movementVector: CGVector, movementSpeedFactor: CGFloat, scene: GameScene) {
        self.movementVector = movementVector
        self.movementSpeedFactor = movementSpeedFactor
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if let node {
            node.position.x += movementVector.dx * movementSpeedFactor * CGFloat(seconds)
            node.position.y += movementVector.dy * movementSpeedFactor * CGFloat(seconds)
        }
    }
}
