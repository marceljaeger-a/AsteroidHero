//
//  MainMenuView.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 29.11.24.
//

import Foundation
import SwiftUI

struct MainMenuView: View {
    var body: some View {
        ZStack {
            
            Image(.background)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .blur(radius: 1, opaque: true)
            
            VStack {
                Spacer()
                
                Text("Asteorid Hero")
                    .font(.largeTitle)
                    .bold()
                    .monospaced()
                    .foregroundStyle(.orange.gradient)
                
                Spacer()
                
                VStack {
                    Text("Recordtime: \(Duration.seconds(player.recordTime).formatted())")
                        .font(.title3)
                        .monospaced()
                        .foregroundStyle(.white)
                    
                    Button {
                        isPlaying.toggle()
                    } label: {
                        Text("Play")
                            .font(.title)
                            .bold()
                            .monospaced()
                            .padding(5)
                            .frame(width: 250)
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                }
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .topLeading) {
                
                //TODO: Design own coins!
                EmeraldLabel(emeralds: player.emeralds)
                    .padding()
                
            }
            
            
        }
    }
    
    @Binding var isPlaying: Bool
    
    @Environment(Player.self) var player: Player
}
