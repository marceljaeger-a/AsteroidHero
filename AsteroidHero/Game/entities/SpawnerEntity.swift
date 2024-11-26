//
//  AsteoridSpawnerEntity.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 26.11.24.
//

import Foundation
import SpriteKit
import GameplayKit

class SpawnerEntity: GKEntity {
    init(scene: GameScene) {
        super.init()
        
        scene.entities.append(self)
        
        self.addComponent(AsteroidSpawningComponent(scene: scene))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
