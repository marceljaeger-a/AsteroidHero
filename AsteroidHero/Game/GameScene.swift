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
    
    //GameLevels
    var gameLevels: GameLevelStairs = .init(gameLevels: [
        GameLevel(level: 1, time: 0, updates: [
            AsteoridSpawningParameterUpdates(spawningRate: .set(value: 5), spawningCount: .set(value: 1), asteoridSpeed: .set(value: 20))
        ]),
        GameLevel(level: 2, time: 15, updates: [
            AsteoridSpawningParameterUpdates(spawningRate: .increase(value: -0.5), spawningCount: .increase(value: 1), asteoridSpeed: .multiple(value: 1.10))
        ]),
        GameLevel(level: 3, time: 30, updates: [
            AsteoridSpawningParameterUpdates(spawningRate: .increase(value: -0.5), spawningCount: .increase(value: 1), asteoridSpeed: .multiple(value: 1.10))
        ]),
        GameLevel(level: 4, time: 45, updates: [
            AsteoridSpawningParameterUpdates(spawningRate: .increase(value: -0.5), spawningCount: .increase(value: 1), asteoridSpeed: .multiple(value: 1.10))
        ])
    ])
    
    init(stats: GameStats) {
        self.stats = stats
        
        super.init(size: .init(width: 256, height: 128))
        self.scaleMode = .aspectFit
        self.anchorPoint = .zero
        
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
        updateGameLevel(currentTime: currentTime)
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
            if let magicNode = magicEntity.component(ofType: ShapeComponent.self)?.shape {
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
    
    private func updateGameLevel(currentTime: TimeInterval) {
        
        if let firstUpdateTime {
            
            let gameTime = currentTime - firstUpdateTime
            
            if let nextLevel = gameLevels.nextLevel, nextLevel.time <= gameTime {
                
                gameLevels.step(to: nextLevel, scene: self)
                
            }
            
        }
        
    }
}
