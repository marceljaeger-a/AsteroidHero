//
//  AsteoridSpawningParameterUpdates.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 28.11.24.
//

import Foundation

struct AsteoridSpawningParameterUpdates: GameLevelUpdate {
    let spawningRate: GameParameterUpdate<TimeInterval>
    let spawningCount: GameParameterUpdate<Int>
    let asteoridSpeed: GameParameterUpdate<CGFloat>
    
    func updateParameters(scene: GameScene) {
        if let spawnerEntitiy = scene.entities.first(where: { $0 is SpawnerEntity }), let asteoridSpawningComponent = spawnerEntitiy.component(ofType: AsteroidSpawningComponent.self) {
            
            asteoridSpawningComponent.spawingRate = spawningRate.change(value: asteoridSpawningComponent.spawingRate)
            asteoridSpawningComponent.spawningCount = spawningCount.change(value: asteoridSpawningComponent.spawningCount)
            asteoridSpawningComponent.asteoridSpeed = asteoridSpeed.change(value: asteoridSpawningComponent.asteoridSpeed)
            
        }
    }
}
