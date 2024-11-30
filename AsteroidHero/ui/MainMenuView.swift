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
                    Text("Recordtime: \("00:10:00")")
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
            .frame(maxWidth: .infinity)
            .overlay(alignment: .topLeading) {
                
                //TODO: Design own coins!
                Label {
                    Text("100")
                        .foregroundStyle(.white)
                } icon: {
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundStyle(.yellow)
                }
                .font(.title)
                .monospaced()
                
            }
            .padding()
            
        }
    }
    
    @Binding var isPlaying: Bool
}