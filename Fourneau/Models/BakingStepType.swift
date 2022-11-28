//
//  BakingStepType.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

enum BakingStepType: String, Codable, Identifiable {
    case feedStarter
    case makeDough
    case proof
    case form
    case benchRest
    case bake
    
    var name: String {
        rawValue.capitalized
    }
    var id: String {
        name
    }
}
