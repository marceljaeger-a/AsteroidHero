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
        
        _ = EarthEntity(scene: self)
        _ = HeroEntity(scene: self)
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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for component in (entities.flatMap { $0.components }) {
            if let userInteractivableComponent = component as? (UserInteractivableComponent & GKComponent) {
                userInteractivableComponent.onTouchesBegan(touches, with: event)
            }
        }
    }
}
