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
        
        let y = scene.frame.maxY + 25
        let xRange = Int(scene.frame.minX)+50...Int(scene.frame.maxX)-50
        let x = CGFloat(xRange.randomElement() ?? xRange.lowerBound)
        let startPoint = CGPoint(x: x, y: y)
        let movementVector = CGVector(dx: 0, dy: -20)
        
        if secondsBuffer > spawingRate {

            spawnAsteroid(point: startPoint, movementVector: movementVector)
            secondsBuffer = 0
            
        }
    }
    
    func spawnAsteroid(point: CGPoint, movementVector: CGVector) {
        _ = AsteoridEntity(position: point, movementVector: movementVector, healthPoints: 1, attackDamage: 1, scene: scene)
    }
}
