//
//  BakingStep.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import Foundation
import SwiftUI

struct BakingStep: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var lengthInMinutes: Int
    var description: [String]
    var methodCompleted: [Bool]
    var type: BakingStepType
    
    init(id: UUID = UUID(), title: String, startingTime: Date = Date(), lengthInMinutes: Int, description: [String] = [], type: BakingStepType) {
        self.id = id
        self.title = title
        self.lengthInMinutes = lengthInMinutes < 0 ? 0 : lengthInMinutes
        self.description = description.count > 0 ? description : type.description
        self.type = type
        self.methodCompleted = [Bool](repeating: false, count: self.description.count)
    }
    
    mutating func updateDescription(description array: [String]) {
        description = array
        methodCompleted = [Bool](repeating: false, count: self.description.count)
    }
    
    struct Data {
        var title: String = ""
        var lengthInMinutes: Int = 0
        var description: [String] = []
        var type: BakingStepType = .proof
    }
    
    var data: Data {
        Data(title: title, lengthInMinutes: lengthInMinutes, description: description, type: type)
    }
    
    init(data: Data) {
        id = UUID()
        title = data.title
        lengthInMinutes = data.lengthInMinutes < 0 ? 0 : data.lengthInMinutes
        description = data.description.count > 0 ? data.description : data.type.description
        type = data.type
        methodCompleted = [Bool](repeating: false, count: self.description.count)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        lengthInMinutes = data.lengthInMinutes
        description = data.description
        type = data.type
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
