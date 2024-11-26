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
    var spawingRate: TimeInterval = 5
    var spawningCount: Int = 1
    var asteoridSpeed: CGFloat = 20
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
            
            //Spawn
            for i in 0..<spawningCount {
                spawnAsteroid()
            }
            
            secondsBuffer = 0
        }
    }
    
    func spawnAsteroid() {
        let y = scene.frame.maxY + 10
        let xRange = Int(scene.frame.minX)+10...Int(scene.frame.maxX)-10
        
        let x = CGFloat(xRange.randomElement() ?? xRange.lowerBound)
        let startPoint = CGPoint(x: x, y: y)
        let movementVector = CGVector(dx: 0, dy: -1 * asteoridSpeed)
        
        _ = AsteoridEntity(position: startPoint, movementVector: movementVector, healthPoints: 1, attackDamage: 1, scene: scene)
    }
}
