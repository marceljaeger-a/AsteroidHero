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
            
            GameView()
            
        }else {
            
            MainMenuView(isPlaying: $isPlaying)
            
        }
        
    }
    
    @State private var isPlaying: Bool = false
}


#Preview {
    ContentView()
}
