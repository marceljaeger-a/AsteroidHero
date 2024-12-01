//
//  EmeraldLabel.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 01.12.24.
//

import Foundation
import SwiftUI

struct EmeraldLabel: View {
    var body: some View {
        Label {
            Text("\(emeralds)")
                .foregroundStyle(.white)
        } icon: {
            Image(systemName: "octagon.fill")
                .foregroundStyle(.green)
        }
        .font(.title)
        .monospaced()
    }
    
    let emeralds: Int
}
