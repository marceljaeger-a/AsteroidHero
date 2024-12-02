//
//  Sound.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 02.12.24.
//

import Foundation
import SpriteKit

struct Sound {
    
    let soundNode: SKAudioNode
    
    init(name: String, soundFile: String, scene: GameScene) {
        soundNode = SKAudioNode(fileNamed: soundFile)
        soundNode.autoplayLooped = false
        scene.addChild(soundNode)
    }
    
    func play() {
        soundNode.run(.play())
    }
    
    func destroy() {
        soundNode.run(.removeFromParent())
    }
}
