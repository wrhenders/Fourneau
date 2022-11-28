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
    let startingTime: Date
    var lengthInMinutes: Double
    var endingTime: Date
    var description: String
    var type: BakingStepType
    
    init(id: UUID = UUID(), title: String, lengthInMinutes: Double, description: String, type: BakingStepType) {
        self.id = id
        self.title = title
        self.startingTime = Date()
        self.lengthInMinutes = lengthInMinutes
        self.endingTime = Date(timeInterval: lengthInMinutes * 60, since: startingTime)
        self.description = description
        self.type = type
    }
}

extension BakingStep {
    static let sampleData: BakingStep = BakingStep(title: "Proof", lengthInMinutes: 15, description: "Let mixture rise", type: .proof)
}
