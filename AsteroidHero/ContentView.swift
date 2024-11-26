//
//  ContentView.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 25.11.24.
//

import SwiftUI
import SpriteKit
import GameplayKit

@Observable class GameStats {
    var lost: Bool = false
    var earthHealthPoints: Int = 0
    var startDate: Date? = .now
    var endDate: Date? = nil
}

struct ContentView: View {
    var body: some View {
        
        if gameStats.lost == false {
            
            SpriteView(scene: GameScene(stats: gameStats))
                .overlay {
                    
                    GameStatsView(gameStats: gameStats)
                    
                }
            
        } else {
            
            VStack {
                
                Text("You lost!")
                    .font(.largeTitle)
                    .bold()
                
                if let startDate = gameStats.startDate, let endDate = gameStats.endDate {
                    Text("\(Duration.seconds(DateInterval(start: startDate, end: endDate).duration).formatted(Duration.TimeFormatStyle(pattern: .hourMinuteSecond)))")
                        .font(.title)
                        .monospaced()
                        .bold()
                    
                }
                
            }
            
        }
        
    }
    
    @State private var gameStats = GameStats()
}

struct GameStatsView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Label("\(gameStats.earthHealthPoints)", systemImage: "heart.fill")
                    .foregroundStyle(.red)
                    .font(.title)
                    .monospaced()
                    .bold()
                
                Spacer()
                
                if let startDate = gameStats.startDate {
                    Label {
                        Text(startDate, style: .timer)
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .font(.title)
                    .monospaced()
                    .bold()
                }
            }
            .padding(8)
        }
    }
    
    let gameStats: GameStats
}

#Preview {
    ContentView()
}
