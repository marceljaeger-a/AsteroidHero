//
//  AsteroidSpawningComponent.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 26.11.24.
//

import Foundation
import GameplayKit
import SpriteKit

class AsteroidSpawningComponent: GKComponent {
    let scene: GameScene
    
    //Spawning Parameter
    var spawingRate: TimeInterval = 5
    var spawningCount: Int = 1
    var asteoridSpeed: CGFloat = 20
    var asteoridMinDistance: Int = 20
    var asteoridSpawningPadding: Int = 10
    
    private var secondsBuffer: TimeInterval = 0
    
    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        secondsBuffer += seconds
    
        if secondsBuffer > spawingRate {
            
            spawnAsteroid()
            secondsBuffer = 0
            
        }
    }
    
    func spawnAsteroid() {
        let y = scene.frame.maxY + 10
        let xRange = (Int(scene.frame.minX.rounded(.up)) + asteoridSpawningPadding)...(Int(scene.frame.maxX.rounded(.down)) - asteoridSpawningPadding)
        var xSet = Set(xRange)
   
        for _ in 0..<spawningCount {
            
            if xSet.isEmpty {
                break
            }
            
            if let xRandom = xSet.randomElement() {
                
                let x = CGFloat(xRandom)
                
                let xRemovingRange = (xRandom - asteoridMinDistance)...(xRandom + asteoridMinDistance)
                xSet.subtract(xRemovingRange)
                
                let startPoint = CGPoint(x: x, y: y)
                let movementVector = CGVector(dx: 0, dy: -1 * asteoridSpeed)
                
                _ = AsteoridEntity(position: startPoint, movementVector: movementVector, healthPoints: 1, attackDamage: 1, scene: scene)
                
            }
            
        }
    }
}
