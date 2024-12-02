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
    let attackSoundFile: String?
    
    var attackDamage: Int
    var attackMask: AttackMask
    var attackCount: Int
    
    var node: SKNode? {
        self.entity?.component(ofType: SpriteComponent.self)?.sprite
    }
    
    init(attackDamage: Int, attackMask: AttackMask, attackCount: Int, attackSoundFile: String? = "", scene: GameScene) {
        self.attackDamage = attackDamage
        self.attackMask = attackMask
        self.attackCount = attackCount
        self.attackSoundFile = attackSoundFile
        self.scene = scene
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if let node {
            for entity in (scene.entities.filter { $0.component(ofType: HealthComponent.self) != nil && $0.component(ofType: SpriteComponent.self) != nil }) {
                let healthComponent = entity.component(ofType: HealthComponent.self)!
                let spriteComponent = entity.component(ofType: SpriteComponent.self)!
                
                if healthComponent.attackMask == self.attackMask {
                    
                    if spriteComponent.sprite.intersects(node) {
                        
                        attack(healthComponent: healthComponent)
 
                    }
                    
                }
            }
        }
    }
    
    func attack(healthComponent: HealthComponent) {
        healthComponent.healthPoints -= attackDamage
        attackCount -= 1
        
        if let attackSoundFile {
            self.node?.run(.playSoundFileNamed(attackSoundFile, waitForCompletion: false))
        }
        
        if attackCount <= 0 {
            scene.entities.removeAll { $0 == self.entity }
            self.node?.run(.removeFromParent())
        }
    }
}

enum AttackMask: Int {
    case asteorid
    case earth
}
