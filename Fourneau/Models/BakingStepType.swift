//
//  BakingStepType.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

enum BakingStepType: String, Codable, Identifiable {
    case feedstarter
    case makedough
    case proof
    case form
    case benchrest
    case bake
    
    var name: String {
        rawValue
    }
    var id: String {
        name
    }
}
