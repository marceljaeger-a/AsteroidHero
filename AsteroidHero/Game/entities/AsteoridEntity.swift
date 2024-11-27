//
//  AsteoridEntity.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 26.11.24.
//

import Foundation
import SpriteKit
import GameplayKit

class AsteoridEntity: GKEntity {
    init(position: CGPoint, movementVector: CGVector, movementSpeedFactor: CGFloat, healthPoints: Int, attackDamage: Int, scene: GameScene) {
        super.init()
        
        scene.entities.append(self)
        
        let shape = SKShapeNode(ellipseOf: .init(width: 16, height: 16))
        shape.fillColor = .red
        shape.lineWidth = 0
        shape.position = position
        self.addComponent(ShapeComponent(shape: shape, scene: scene))
        self.addComponent(FlyingComponent(movementVector: movementVector, movementSpeedFactor: movementSpeedFactor, scene: scene))
        
        self.addComponent(HealthComponent(healthPoints: healthPoints, attackMask: .asteorid, isDespawning: true, scene: scene))
        self.addComponent(AttackComponent(attackDamage: attackDamage, attackMask: .earth, attackCount: 1, scene: scene))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
