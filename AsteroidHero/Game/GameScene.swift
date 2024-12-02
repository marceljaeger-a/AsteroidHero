//
//  GameSceneDelegate.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 25.11.24.
//

import Foundation
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let stats: GameStats
    var entities: Array<GKEntity> = []
    
    //Game Phases
    var gamePhases: GamePhases = .init(phases: [
        GamePhase(name: "Phase 1", time: 0, updates: [
            AsteoridSpawningParameterUpdates(spawningRate: .set(value: 5), spawningCount: .set(value: 1), asteoridSpeed: .set(value: 20))
        ]),
        GamePhase(name: "Phase 2", time: 15, updates: [
            AsteoridSpawningParameterUpdates(spawningRate: .set(value: 4), spawningCount: .increase(value: 1), asteoridSpeed: .multiple(value: 1.10))
        ]),
        GamePhase(name: "Phase 3", time: 30, updates: [
            AsteoridSpawningParameterUpdates(spawningRate: .increase(value: 0), spawningCount: .increase(value: 1), asteoridSpeed: .multiple(value: 1))
        ]),
        GamePhase(name: "Phase 4", time: 45, updates: [
            AsteoridSpawningParameterUpdates(spawningRate: .increase(value: 0), spawningCount: .increase(value: 1), asteoridSpeed: .multiple(value: 1))
        ]),
        GamePhase(name: "Phase 5", time: 60, updates: [
            AsteoridSpawningParameterUpdates(spawningRate: .increase(value: 0), spawningCount: .increase(value: 0), asteoridSpeed: .multiple(value: 1.25))
        ]),
        GamePhase(name: "Phase 6", time: 80, updates: [
            AsteoridSpawningParameterUpdates(spawningRate: .increase(value: 0), spawningCount: .increase(value: 1), asteoridSpeed: .multiple(value: 1))
        ]),
        GamePhase(name: "Phase 7", time: 100, updates: [
            AsteoridSpawningParameterUpdates(spawningRate: .set(value: 3), spawningCount: .increase(value: 0), asteoridSpeed: .multiple(value: 1))
        ]),
        GamePhase(name: "Phase 8", time: 120, updates: [
            AsteoridSpawningParameterUpdates(spawningRate: .increase(value: 0), spawningCount: .increase(value: 1), asteoridSpeed: .multiple(value: 1.25))
        ])
    ])
    
    init(stats: GameStats) {
        self.stats = stats
        
        super.init(size: .init(width: 295, height: 140))
        self.scaleMode = .aspectFit
        self.anchorPoint = .zero
        
        let backgroundNode = SKShapeNode(rect: self.frame)
        backgroundNode.lineWidth = 0
        backgroundNode.fillColor = .black
        self.addChild(backgroundNode)
        
        _ = EarthEntity(scene: self)
        _ = HeroEntity(scene: self)
        _ = SpawnerEntity(scene: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var currentTime: TimeInterval? = nil
    var firstUpdateTime: TimeInterval? = nil
    var lastUpdateTime: TimeInterval? = nil
    override func update(_ currentTime: TimeInterval) {
        
        self.currentTime = currentTime
        
        if firstUpdateTime == nil {
            firstUpdateTime = currentTime
        }
        
        if let lastUpdateTime {
            
            let deltaTime = currentTime - lastUpdateTime
            
            for entity in entities {
                
                entity.update(deltaTime: deltaTime)
                
            }
            
            self.lastUpdateTime = currentTime
            
        }else {
            
            self.lastUpdateTime = currentTime
            
        }
        
        cleanUpMagicEntities()
        updateGameStats()
        updateGamePhase(currentTime: currentTime)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for component in (entities.flatMap { $0.components }) {
            if let userInteractivableComponent = component as? (UserInteractivableComponent & GKComponent) {
                userInteractivableComponent.onTouchesBegan(touches, with: event)
            }
        }
    }
    
    private func cleanUpMagicEntities() {
        for magicEntity in (entities.compactMap { $0 as? MagicEntity }) {
            if let magicNode = magicEntity.component(ofType: SpriteComponent.self)?.sprite {
                if magicNode.frame.intersects(self.frame) == false {
                    magicNode.removeFromParent()
                    self.entities.removeAll { $0 == magicEntity}
                }
            }
        }
    }
    
    private func updateGameStats() {
        if let earthEntity = entities.first(where: { $0 is EarthEntity }) {
            if let healthComponent = earthEntity.component(ofType: HealthComponent.self) {
                if stats.earthHealthPoints != healthComponent.healthPoints {
                    stats.earthHealthPoints = healthComponent.healthPoints
                    if stats.earthHealthPoints <= 0 {
                        stats.lost = true
                        stats.endDate = .now
                    }
                }
            }
        }
    }
    
    private func updateGamePhase(currentTime: TimeInterval) {
        
        if let firstUpdateTime {
            
            let gameTime = currentTime - firstUpdateTime
            
            if let nextLevel = gamePhases.next, nextLevel.time <= gameTime {
                
                gamePhases.step(to: nextLevel, scene: self)
                
            }
            
        }
        
    }
}
