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
    
    var lastUpdateTime: TimeInterval? = nil
    override func update(_ currentTime: TimeInterval) {
        
        if let lastUpdateTime {
            
            let deltaTime = currentTime - lastUpdateTime
            
            for entity in entities {
                
                entity.update(deltaTime: deltaTime)
                
            }
            
            self.lastUpdateTime = currentTime
            
        }else {
            
            self.lastUpdateTime = currentTime
            
        }
        
        updateGameStats()
        updateSpawnerEntity(currentTime: currentTime)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for component in (entities.flatMap { $0.components }) {
            if let userInteractivableComponent = component as? (UserInteractivableComponent & GKComponent) {
                userInteractivableComponent.onTouchesBegan(touches, with: event)
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
    
    //TODO: Überschreibe es als Gamelevelupdate
    //Alle 10 Sekunden, als Beispiel, wird das Gamelevel erhöht. Jedes Gamelevel besitzt Paramater, wie einzelne Parameter des Spiels verändert werden.
    //Es wird entweder multipliziert (increaseByFactor), erhöht (increaseByValue) oder explizit gesetzt (set).
    var lastSpawnerUpdateTime: TimeInterval = 0
    private func updateSpawnerEntity(currentTime: TimeInterval) {
        if let spawnerEntitiy = entities.first(where: { $0 is SpawnerEntity }), let statsStartDate = stats.startDate {
          
            if let asteoridSpawningComponent = spawnerEntitiy.component(ofType: AsteroidSpawningComponent.self) {
                
                //Check update time
                if currentTime - lastSpawnerUpdateTime >= 10 {
                    
                    //Update spawning variables
                    asteoridSpawningComponent.spawingRate -= 0.25
                    asteoridSpawningComponent.asteoridSpeed += 0.25
                    asteoridSpawningComponent.spawningCount += 1
                    
                    lastSpawnerUpdateTime = currentTime
                }
                
            }
            
        }
    }
}
