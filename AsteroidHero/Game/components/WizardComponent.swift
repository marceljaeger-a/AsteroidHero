//
//  WizardComponent.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 25.11.24.
//

import Foundation
import GameplayKit
import SpriteKit

class WizardComponent: GKComponent, UserInteractivableComponent {
    
    var magicAttackDamage: Int = 1
    var magicSpeed: CGFloat = 50
    var magicAttackCount: Int = 2
    
    var node: SKNode? {
        self.entity?.component(ofType: ShapeComponent.self)?.shape
    }
    
    init(scene: GameScene) {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func onTouchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let node, let scene = node.scene as? GameScene {
            
            if let firstTouch = touches.first {
                
                //Touch vector
                let touchPoint = firstTouch.location(in: scene)
                let nodePoint = node.position
                let distanceVector = CGVector(dx: touchPoint.x - nodePoint.x, dy: touchPoint.y - nodePoint.y)
                
                //Vector distance
                let distance = ( distanceVector.dx.magnitudeSquared + distanceVector.dy.magnitudeSquared ).squareRoot()
                
                //Movement vector
                let movementVectorX = distanceVector.dx / distance
                let movementVectorY = distanceVector.dy / distance
                let movementVector = CGVector(dx: movementVectorX, dy: movementVectorY)
                
                createMagic(startPosition: node.position, movementVector: CGVector(dx: movementVector.dx * magicSpeed, dy: movementVector.dy * magicSpeed), scene: scene)
                
            }
            
        }
    }
    
    func createMagic(startPosition: CGPoint, movementVector: CGVector, scene: GameScene) {
        _ = MagicEntity(startPosition: startPosition, movementVector: movementVector, attackDamage: magicAttackDamage, attackCount: magicAttackCount, scene: scene)
    }
}
