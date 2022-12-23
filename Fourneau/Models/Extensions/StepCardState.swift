//
//  StepCardState.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/21/22.
//

import SwiftUI

enum CardState: String {
    case current
    case completed
    case incomplete
    case last
    case lastActive
    
    var color: Color {
        switch self {
        case .current, .lastActive:
            return Color.red
        case .completed:
            return Color.green
        default:
            return Color.black
        }
    }
}
