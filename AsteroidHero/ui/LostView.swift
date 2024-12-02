//
//  LostView.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 28.11.24.
//

import Foundation
import SwiftUI
import AVKit

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
        .task {
            Task {
                try await Task.sleep(for: .seconds(0.5))
                audioPlayer?.play()
            }
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
    private let audioPlayer: AVAudioPlayer? = {
        if let path = Bundle.main.path(forResource: "gameover.m4a", ofType: nil){
            let avPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            return avPlayer
        }
        return nil
    }()
    
    @Environment(Player.self) var player: Player
}
