//
//  LostView.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 28.11.24.
//

import Foundation
import SwiftUI

struct LostView: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Game over!")
                .font(.largeTitle)
                .bold()
            
            HStack {
                
                if let time, player.recordTime < time {
                    Text("New record!")
                        .font(.title2)
                        .monospaced()
                        .bold()
                        .foregroundStyle(.indigo.gradient)
                }
                
                if let startDate = gameStats.startDate, let endDate = gameStats.endDate {
                    
                    Text("\(Duration.seconds(DateInterval(start: startDate, end: endDate).duration).formatted(Duration.TimeFormatStyle(pattern: .hourMinuteSecond)))")
                        .font(.title2)
                        .monospaced()
                        .bold()
                    
                }
                
            }
            
            if let wonEmeralds {
                
                EmeraldLabel(emeralds: wonEmeralds)
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            Button {
                isPlaying.toggle()
            } label: {
                Text("Back")
                    .font(.title3)
                    .bold()
                    .monospaced()
                    .padding(5)
                    .foregroundStyle(.white)
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding()
        }
        .onAppear {
            time = gameStats.time
            wonEmeralds = gameStats.wonEmeralds
            
            if let time = gameStats.time, let wonEmeralds = gameStats.wonEmeralds {
                player.emeralds += wonEmeralds
                if time > player.recordTime {
                    player.recordTime = time
                }
            }
        }
    }
    
    let gameStats: GameStats
    @Binding var isPlaying: Bool
    
    @State private var time: TimeInterval? = nil
    @State private var wonEmeralds: Int? = nil
    
    @Environment(Player.self) var player: Player
}
