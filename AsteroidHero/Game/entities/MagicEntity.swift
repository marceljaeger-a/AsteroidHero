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
    init(startPosition: CGPoint, movementVector: CGVector, movementSpeedFactor: CGFloat, attackDamage: Int, attackCount: Int, scene: GameScene) {
        super.init()
        
        let texture = SKTexture(image: .magic)
        texture.filteringMode = .nearest
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = startPosition
        
        //Winkel berechnene
        let dy = movementVector.dy
        let dx = movementVector.dx
        let rotation = atan2(dx, dy)
        
        sprite.zRotation = ( (.pi / 180) * 180 ) - rotation
        
        self.addComponent(SpriteComponent(sprite: sprite, scene: scene))
        self.addComponent(FlyingComponent(movementVector: movementVector, movementSpeedFactor: movementSpeedFactor, scene: scene))
        
        self.addComponent(AttackComponent(attackDamage: attackDamage, attackMask: .asteorid, attackCount: attackCount, scene: scene))
        
        scene.entities.append(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
