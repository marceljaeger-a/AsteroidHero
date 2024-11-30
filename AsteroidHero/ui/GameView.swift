//
//  GameView.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 28.11.24.
//

import Foundation
import SwiftUI
import SpriteKit


@Observable class GameStats {
    var lost: Bool = false
    var earthHealthPoints: Int = 0
    var startDate: Date? = .now
    var endDate: Date? = nil
}


struct GameView: View {
    var body: some View {
        if gameStats.lost == false {
            
            SpriteView(scene: GameScene(stats: gameStats))
                .ignoresSafeArea()
                .overlay {
                    
                    GameStatsView(gameStats: gameStats)
                    
                }
            
        } else {
            
            LostView(gameStats: gameStats)
            
        }
    }
    
    @State private var gameStats = GameStats()
}


struct GameStatsView: View {
    var body: some View {
        VStack {
            
            ZStack {
                
                HStack {
                    Label("\(gameStats.earthHealthPoints)", systemImage: "heart.fill")
                        .foregroundStyle(.red)
                        .font(.title2)
                        .monospaced()
                        .bold()
                    
                    Spacer()
                }
                
                if let startDate = gameStats.startDate {
                    Label {
                        Text(startDate, style: .timer)
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .labelStyle(.titleOnly)
                    .font(.title2)
                    .monospaced()
                    .bold()
                }
                
            }
            .padding(10)
            
            Spacer()
        }
    }
    
    let gameStats: GameStats
}
