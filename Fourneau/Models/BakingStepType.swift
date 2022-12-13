//
//  BakingStepType.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

enum BakingStepType: String, Codable, Identifiable, CaseIterable {
    case feedstarter
    case makedough
    case autolyse
    case proof
    case form
    case benchrest
    case bake
    case cool
    case wait
    
    var name: String {
        rawValue
    }
    var id: String {
        name
    }
    
    var title: String {
        switch self {
        case .feedstarter:
            return "Feed Starter"
        case .benchrest:
            return "Bench Rest"
        case .makedough:
            return "Make Dough"
        default:
            return rawValue.capitalized
        }
    }
    
    var description: [String] {
        switch self {
        case .feedstarter:
            return ["Mix Equal Parts Flour and Water"]
        case .makedough:
            return ["(Based on Recipe)"]
        case .autolyse:
            return ["Let rest 15 minutes before adding salt", "Add Salt and mix to combine"]
        case .proof:
            return ["Let rest"]
        case .form:
            return ["Form the Dough on Forneau Silpat"]
        case .benchrest:
            return ["Let the dough rest on a table to form slightly dry exterior"]
        case .bake:
            return ["With oven at baking temp, slide tray into oven.","Pour 50g water into trough, close Forneau and oven.","Once half the baking time has passed, remove door and continue baking"]
        case .cool:
            return ["Let cool on wire rack to finish cooking"]
        case .wait:
            return ["Just relax, you've got time before beginning to bake"]
        }
    }
}
