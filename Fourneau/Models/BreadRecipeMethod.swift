//
//  BreadRecipe.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import Foundation

struct BreadRecipeMethod: Codable, Identifiable, Equatable, Hashable {
    let id: UUID
    var title: String
    var steps: [BakingStep] = []
    var locked: Bool = false
    
    init(title: String, steps: [BakingStep], locked: Bool = false) {
        self.id = UUID()
        self.title = title
        self.steps = steps
    }
    
    var totalTime: Int {
        return steps.map{$0.lengthInMinutes}.reduce(0,+)
    }
    
    struct Data {
        var title: String = ""
        var steps: [BakingStep] = []
    }
    
    var data: Data {
        Data(title: title, steps: steps)
    }
    
    init(data: Data) {
        id = UUID()
        title = data.title
        steps = data.steps
    }
}

extension BreadRecipeMethod {
    init(title: String = "Standard Method") {
        self.id = UUID()
        self.title = title
        self.steps = [
            BakingStep(title: "Feed Starter", lengthInMinutes: 360, temp: 90, type: .feedstarter),
            BakingStep(title: "Feed Starter Again", lengthInMinutes: 240, temp: 90, type: .feedstarter),
            BakingStep(title: "Mix Dough", lengthInMinutes: 5, type: .makedough),
            BakingStep(title: "Proof/Rest Dough", lengthInMinutes: 600, type: .proof),
            BakingStep(title: "Bench Rest", lengthInMinutes: 15, type: .benchrest),
            BakingStep(title: "Form", lengthInMinutes: 5, type: .form),
            BakingStep(title: "Bake", lengthInMinutes: 50, description: ["With oven at temp, slide tray into oven.","Pour 50g water into trough, close Forneau and oven.","Once half the time has passed, remove door and continue baking"], type: .bake),
            BakingStep(title: "Cool", lengthInMinutes: 20, type: .cool)
        ]
        self.locked = true
    }
}
