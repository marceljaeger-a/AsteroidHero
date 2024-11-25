//
//  ContentView.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 25.11.24.
//

import SwiftUI
import SpriteKit
import GameplayKit

struct ContentView: View {
    var body: some View {
        SpriteView(scene: GameScene())
    }
}

#Preview {
    ContentView()
}
