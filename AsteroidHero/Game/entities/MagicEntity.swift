//
//  MagicEntity.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 25.11.24.
//

import Foundation
import SpriteKit
import GameplayKit

class MagicEntity: GKEntity {
    init(startPosition: CGPoint, movementVector: CGVector, attackDamage: Int, attackCount: Int, scene: GameScene) {
        super.init()
        
        let shape = SKShapeNode(ellipseOf: .init(width: 16, height: 16))
        shape.lineWidth = 0
        shape.fillColor = .orange
        shape.position = startPosition
        self.addComponent(ShapeComponent(shape: shape, scene: scene))
        self.addComponent(FlyingComponent(movementVector: movementVector, scene: scene))
        
        self.addComponent(AttackComponent(attackDamage: attackDamage, attackMask: .asteorid, attackCount: attackCount, scene: scene))
        
        scene.entities.append(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
