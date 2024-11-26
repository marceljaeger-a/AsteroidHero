//
//  UserInteractivable.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 25.11.24.
//

import Foundation
import SpriteKit
import GameplayKit

protocol UserInteractivableComponent {
    func onTouchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
}

extension UserInteractivableComponent {
    func onTouchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
