//
//  HeroEntity.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 25.11.24.
//

import Foundation
import GameplayKit
import SpriteKit

class HeroEntity: GKEntity {
    init(scene: GameScene) {
        super.init()
        
        let texture = SKTexture(image: .hero)
        texture.filteringMode = .nearest
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = .init(x: 147.5, y: 24)
        self.addComponent(SpriteComponent(sprite: sprite, scene: scene))
        self.addComponent(WizardComponent(scene: scene))
        
        scene.entities.append(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
