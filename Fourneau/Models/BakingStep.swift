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
    var description: [String]
    var methodCompleted: [Bool]
    var type: BakingStepType
    
    init(id: UUID = UUID(), title: String, startingTime: Date = Date(), lengthInMinutes: Double, description: [String] = [], type: BakingStepType) {
        self.id = id
        self.title = title
        self.lengthInMinutes = lengthInMinutes
        self.description = description.count > 0 ? description : type.description
        self.type = type
        self.methodCompleted = [Bool](repeating: false, count: self.description.count)
    }
}

extension BakingStep {
    static let sampleData: [BakingStep] =
    [
        BakingStep(title: "Feed Starter", lengthInMinutes: 60, type: .feedstarter),
        BakingStep(title: "Make Dough", lengthInMinutes: 15, description: ["Follow These Steps: \n","(Insert Recipe)"], type: .makedough),
        BakingStep(title: "Proof", lengthInMinutes: 15, description: ["Let mixture rise", "Fold", "Let rise again"], type: .proof)
    ]
}
