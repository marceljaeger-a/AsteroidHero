//
//  ParameterUpdate.swift
//  AsteroidHero
//
//  Created by Marcel Jäger on 27.11.24.
//

import Foundation

enum GameParameterUpdate<V: Numeric> {
    case set(value: V)
    case multiple(value: V)
    case increase(value: V)
    
    func change(value: V) -> V {
        switch self {
        case .set(let newValue):
            return newValue
        case .multiple(let factor):
            return value * factor
        case .increase(let add):
            return value + add
        }
    }
}
