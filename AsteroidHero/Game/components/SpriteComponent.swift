//
//  SpriteComponent.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 29.11.24.
//

import Foundation
import GameplayKit
import SpriteKit

class SpriteComponent: GKComponent {
    let sprite: SKSpriteNode
    
    init(sprite: SKSpriteNode, scene: GameScene) {
        self.sprite = sprite
        super.init()
        
        scene.addChild(sprite)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
