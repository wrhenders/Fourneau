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
    var stepCompleted: [Bool] = []
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
        self.nextAction = Date(timeInterval: TimeInterval(steps[0].lengthInMinutes * 60), since: startTime)
        self.updateStarts()
        self.setCompletedArray()
    }
    
    mutating func setCompletedArray() {
        stepCompleted = [Bool](repeating: false, count: steps.count)
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
    
    mutating func removeStep(atOffset offsets: IndexSet) {
        steps.remove(atOffsets: offsets)
        setCompletedArray()
        updateStarts()
    }
    
    mutating func addStep(from data: BakingStep.Data) {
        steps.append(BakingStep(data: data))
        setCompletedArray()
        updateStarts()
    }
    
    mutating func updateStep(from data: BakingStep.Data, at index: Int) {
        if steps.indices.contains(index) {
            steps[index] = BakingStep(data: data)
            setCompletedArray()
            updateStarts()
        }
    }
}

extension BreadRecipeMethod {
    init(title: String = "Standard Recipe", recipe: BreadRecipe, startTime: Date = Date()) {
        self.id = UUID()
        self.title = title
        self.recipe = recipe
        self.steps = [
            BakingStep(title: "Feed Starter", lengthInMinutes: 360, type: .feedstarter),
            BakingStep(title: "Feed Starter Again", lengthInMinutes: 240, type: .feedstarter),
            BakingStep(title: "Mix Dough", lengthInMinutes: 5, description: recipe.method, type: .makedough),
            BakingStep(title: "Proof/Rest Dough", lengthInMinutes: 600, type: .proof),
            BakingStep(title: "Bench Rest", lengthInMinutes: 15, type: .benchrest),
            BakingStep(title: "Form", lengthInMinutes: 5, type: .form),
            BakingStep(title: "Bake", lengthInMinutes: recipe.bakeTimeInMinutes, description: ["With oven at \(recipe.bakeTempF)F, slide tray into oven.","Pour 50g water into trough, close Forneau and oven.","Once half the time has passed, remove door and continue baking"], type: .bake),
            BakingStep(title: "Cool", lengthInMinutes: 20, type: .cool)
        ]
        self.startTime = startTime
        self.stepCompleted = [Bool](repeating: false, count: steps.count)
        self.nextAction = Date(timeInterval: TimeInterval(steps[0].lengthInMinutes * 60), since: startTime)
        self.updateStarts()
    }
}
