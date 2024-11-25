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
    
    var entities: Array<GKEntity> = []
    
    override init() {
        super.init(size: .init(width: 256, height: 128))
        self.scaleMode = .aspectFit
        self.anchorPoint = .zero
        
        entities.append(EarthEntity(scene: self))
        entities.append(HeroEntity(scene: self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
