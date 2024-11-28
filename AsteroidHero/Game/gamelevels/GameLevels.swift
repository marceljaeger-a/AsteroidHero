//
//  GameLevels.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 28.11.24.
//

import Foundation

struct GameLevelStairs {
    let gameLevels: [GameLevel]
    var currentLevel: GameLevel?
    
    var firstLevel: GameLevel? {
        gameLevels.first
    }
    
    var lastLevel: GameLevel? {
        gameLevels.last
    }
    
    var nextLevel: GameLevel? {
        if let currentLevel, let currentLevelIndex = (gameLevels.firstIndex { $0 == currentLevel }), currentLevelIndex < gameLevels.count-1 {
            
            return gameLevels[currentLevelIndex+1]
            
        }else {
            
            return firstLevel
            
        }
    }
    
    mutating func step(to gameLevel: GameLevel, scene: GameScene) {
        currentLevel = gameLevel
        gameLevel.performUpdates(scene: scene)
    }
}


struct GameLevel: Hashable {
    var level: Int
    var time: TimeInterval
    var updates: Array<any GameLevelUpdate>
    
    func performUpdates(scene: GameScene) {
        print("Perform update of Level \(level)")
        for update in updates {
            update.updateParameters(scene: scene)
        }
    }
    
    func isTime(gameTime: TimeInterval) -> Bool {
        time <= gameTime
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(level)
        hasher.combine(time)
    }
    
    static func == (lhs: GameLevel, rhs: GameLevel) -> Bool {
        lhs.level == rhs.level && lhs.time == rhs.time
    }
}


protocol GameLevelUpdate {
    func updateParameters(scene: GameScene)
}
