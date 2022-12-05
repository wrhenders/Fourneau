//
//  BreadRecipe.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import Foundation

struct BreadRecipeMethod: Codable, Identifiable {
    let id: UUID
    var title: String
    var steps: [BakingStep]
    var stepCompleted: [Bool]
    var recipe: BreadRecipe
    var startTime: Date
    var startArray: [Date] = []
    var nextAction: Date
    var currentStep: Int = 0
    var endTime: Date {
        Date(timeInterval: TimeInterval(steps[steps.count - 1].lengthInMinutes * 60), since: startArray[startArray.count - 1])
    }
    
    init(id: UUID = UUID(), title: String, steps: [BakingStep], recipe: BreadRecipe, startTime: Date = Date()) {
        self.id = id
        self.title = title
        self.steps = steps
        self.recipe = recipe
        self.startTime = startTime
        self.stepCompleted = [Bool](repeating: false, count: steps.count)
        self.nextAction = Date(timeInterval: TimeInterval(steps[0].lengthInMinutes * 60), since: startTime)
        self.updateStarts()
    }
    
    mutating func updateStarts() {
        var currentStart = Date()
        for (index, step) in steps.enumerated() {
            if stepCompleted[index] {
                continue
            }
            startArray.indices.contains(index) ? startArray[index] = currentStart : startArray.append(currentStart)
            currentStart = Date(timeInterval: TimeInterval(step.lengthInMinutes * 60), since: currentStart)
        }
    }
    
    mutating func nextStep() {
        if currentStep + 1 < steps.count {
            stepCompleted[currentStep] = true
            updateStarts()
            currentStep += 1
            nextAction = Date(timeInterval: TimeInterval(steps[currentStep].lengthInMinutes * 60), since: Date())
        }
    }
}

extension BreadRecipeMethod {
    init(title: String = "Standard Recipe", recipe: BreadRecipe, startTime: Date = Date()) {
        self.id = UUID()
        self.title = title
        self.recipe = recipe
        self.steps = [
            BakingStep(title: "Feed Starter", lengthInMinutes: 360, description: ["Mix Equal Parts Flour and Water"], type: .feedstarter),
            BakingStep(title: "Feed Starter Again", lengthInMinutes: 240, description: ["Mix Equal Parts Flour and Water"], type: .feedstarter),
            BakingStep(title: "Mix Dough", lengthInMinutes: 5, description: [recipe.method], type: .makedough),
            BakingStep(title: "Proof/Rest Dough", lengthInMinutes: 600, description: ["Let rest for 10 hours", "Preheat oven to \(recipe.bakeTempF)F in the last hour"], type: .proof),
            BakingStep(title: "Bench Rest", lengthInMinutes: 15, description: ["Let the dough rest on a table to form slightly dry exterior"], type: .benchrest),
            BakingStep(title: "Form", lengthInMinutes: 5, description: ["Form the Dough on Forneau Silpat"], type: .form),
            BakingStep(title: "Bake", lengthInMinutes: recipe.bakeTimeInMinutes, description: ["With oven at \(recipe.bakeTempF)F, slide tray into oven.","Pour 50g water into trough, close Forneau and oven.","Once \(Int(recipe.bakeTimeInMinutes / 2)) minutes have passed, remove door and continue baking"], type: .bake),
            BakingStep(title: "Cool", lengthInMinutes: 20, description: ["Let cool on wire rack to finish cooking"], type: .cool)
        ]
        self.startTime = startTime
        self.stepCompleted = [Bool](repeating: false, count: steps.count)
        self.nextAction = Date(timeInterval: TimeInterval(steps[0].lengthInMinutes * 60), since: startTime)
        self.updateStarts()
    }
}
