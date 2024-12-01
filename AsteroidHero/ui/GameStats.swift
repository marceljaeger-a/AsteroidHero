//
//  GameStats.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 01.12.24.
//

import Foundation
import SwiftUI
import SpriteKit


@Observable class GameStats {
    var lost: Bool = false
    var earthHealthPoints: Int = 0
    var startDate: Date? = .now
    var endDate: Date? = nil
    
    var time: TimeInterval? {
        if let startDate, let endDate {
            return endDate.timeIntervalSince(startDate)
        }
        return nil
    }
    
    var wonEmeralds: Int? {
        if let time {
            let emeralds = time/10
            return Int(emeralds.rounded(.down))
        }
        return nil
    }
}
