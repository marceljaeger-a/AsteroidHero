//
//  ContentView.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 25.11.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
    
        if isPlaying {
            
            GameView(isPlaying: $isPlaying)
                .environment(player)
            
        }else {
            
            MainMenuView(isPlaying: $isPlaying)
                .environment(player)
            
        }
        
    }
    
    @State private var isPlaying: Bool = false
    @State private var player: Player = .init()
}


#Preview {
    ContentView()
}
