//
//  AttackComponent.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 26.11.24.
//

import Foundation
import GameplayKit
import SpriteKit

class AttackComponent: GKComponent {
    
    let scene: GameScene
    
    var attackDamage: Int
    var attackMask: AttackMask
    
    var node: SKNode? {
        self.entity?.component(ofType: ShapeComponent.self)?.shape
    }
    
    init(attackDamage: Int, attackMask: AttackMask, scene: GameScene) {
        self.attackDamage = attackDamage
        self.attackMask = attackMask
        self.scene = scene
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if let node {
            for entity in (scene.entities.filter { $0.component(ofType: HealthComponent.self) != nil && $0.component(ofType: ShapeComponent.self) != nil }) {
                let healthComponent = entity.component(ofType: HealthComponent.self)!
                let shapeComponent = entity.component(ofType: ShapeComponent.self)!
                
                if healthComponent.attackMask == self.attackMask {
                    
                    if shapeComponent.shape.intersects(node) {
                        
                        //Attack
                        attack(healthComponent: healthComponent)
  
                        scene.entities.removeAll { $0 == self.entity }
                        node.removeFromParent()
                    }
                    
                }
            }
        }
    }
    
    func attack(healthComponent: HealthComponent) {
        healthComponent.healthPoints -= attackDamage
        
        print("Attack!")
    }
}

enum AttackMask: Int {
    case asteorid
    case earth
}
