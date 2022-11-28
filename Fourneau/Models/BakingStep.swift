//
//  BakingStep.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import Foundation
import SwiftUI

struct BakingStep: Identifiable, Codable {
    let id: UUID
    var title: String
    var lengthInMinutes: Double
    var description: String
    var type: BakingStepType
    
    init(id: UUID = UUID(), title: String, startingTime: Date = Date(), lengthInMinutes: Double, description: String, type: BakingStepType) {
        self.id = id
        self.title = title
        self.lengthInMinutes = lengthInMinutes
        self.description = description
        self.type = type
    }
}

extension BakingStep {
    static let sampleData: [BakingStep] =
    [
        BakingStep(title: "Feed Starter", lengthInMinutes: 60, description: "Feed your starter with equal parts water and flour", type: .feedstarter),
        BakingStep(title: "Make Dough", lengthInMinutes: 15, description: "Follow These Steps: \n (Insert Recipe)", type: .makedough),
        BakingStep(title: "Proof", lengthInMinutes: 15, description: "Let mixture rise", type: .proof)
    ]
}
