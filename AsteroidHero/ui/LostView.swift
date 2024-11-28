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
    
    let gameStats: GameStats
}
