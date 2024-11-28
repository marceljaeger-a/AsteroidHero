//
//  GameLevels.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 28.11.24.
//

import Foundation

struct GamePhases {
    let phases: [GamePhase]
    var current: GamePhase?
    
    var first: GamePhase? {
        phases.first
    }
    
    var last: GamePhase? {
        phases.last
    }
    
    var next: GamePhase? {
        if let current, let currentLevelIndex = (phases.firstIndex { $0 == current }) {
            
            if currentLevelIndex < phases.count-1 {
                
                return phases[currentLevelIndex+1]
                                
            }
            
            return nil
            
        }else {
            
            return first
            
        }
    }
    
    mutating func step(to phase: GamePhase, scene: GameScene) {
        current = phase
        phase.performUpdates(scene: scene)
    }
}


struct GamePhase: Hashable {
    var name: String
    var time: TimeInterval
    var updates: Array<any GamePhaseUpdate>
    
    func performUpdates(scene: GameScene) {
        print("Perform updates of \(name)")
        for update in updates {
            update.updateParameters(scene: scene)
        }
    }
    
    func isTime(gameTime: TimeInterval) -> Bool {
        time <= gameTime
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(time)
    }
    
    static func == (lhs: GamePhase, rhs: GamePhase) -> Bool {
        lhs.name == rhs.name && lhs.time == rhs.time
    }
}


protocol GamePhaseUpdate{
    func updateParameters(scene: GameScene)
}
