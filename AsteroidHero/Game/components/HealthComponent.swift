//
//  HealthComponent.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 26.11.24.
//

import Foundation
import GameplayKit
import SpriteKit

class HealthComponent: GKComponent {
    
    let scene: GameScene
    var healthPoints: Int
    var attackMask: AttackMask
    var isDespawning: Bool
    
    init(healthPoints: Int, attackMask: AttackMask, isDespawning: Bool, scene: GameScene) {
        self.healthPoints = healthPoints
        self.attackMask = attackMask
        self.isDespawning = isDespawning
        self.scene = scene
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if healthPoints <= 0 {
            
            if isDespawning {
                
                scene.entities.removeAll { $0 == entity }
                if let spriteComponent = self.entity?.component(ofType: SpriteComponent.self) {
                    
                    spriteComponent.sprite.removeFromParent()
                    
                }
                
            }
            
        }
    }
}
