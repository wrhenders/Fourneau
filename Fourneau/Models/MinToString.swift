//
//  MinToString.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/16/22.
//

extension Int {
    func minToString() -> String {
        let minutes = self % 60
        
        switch self {
        case 0...1: return "\(self) Minute"
        case 2...59: return "\(self) Minutes"
        case 60...119: return minutes > 0 ? "\(self / 60) Hour \(minutes) Minutes" : "\(self / 60) Hour"
        case 120...: return minutes > 0 ? "\(self / 60) Hours \(minutes) Minutes" : "\(self / 60) Hours"
        default: return ""
        }
    }
}
