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
    init(scene: GameScene) {
        super.init()
    
        let texture = SKTexture(image: .ground)
        texture.filteringMode = .nearest
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = .init(x: 147.5, y: 8)
        self.addComponent(SpriteComponent(sprite: sprite, scene: scene))
        self.addComponent(HealthComponent(healthPoints: 3, attackMask: .earth, isDespawning: false, scene: scene))
        
        scene.entities.append(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
