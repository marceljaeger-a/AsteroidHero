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
    let movementVector: CGVector
    
    var node: SKNode? {
        self.entity?.component(ofType: ShapeComponent.self)?.shape
    }
    
    init(movementVector: CGVector, scene: GameScene) {
        self.movementVector = movementVector
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if let node {
            node.position.x += movementVector.dx * CGFloat(seconds)
            node.position.y += movementVector.dy * CGFloat(seconds)
        }
    }
}
