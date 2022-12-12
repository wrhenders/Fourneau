//
//  CompletedRecipe.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/8/22.
//

import Foundation

struct CompletedRecipeTimer: Codable, Identifiable {
    let id: UUID
    var startTime: Date = Date()
    var steps: [BakingStep] = BreadRecipeMethod().steps
    var recipe: BreadRecipe = BreadRecipe.sampleRecipe
    
    var stepCompleted: [Bool] = []
    var startArray: [Date] = []
    var nextAction: Date?
    var currentStep: Int = 0
    var endTime: Date {
        steps.count > 0 ?
        Date(timeInterval: TimeInterval(steps[steps.count - 1].lengthInMinutes * 60), since: startArray[startArray.count - 1]) :
        Date()
    }
    
    init(steps: [BakingStep], recipe: BreadRecipe) {
        self.id = UUID()
        self.steps = steps
        self.recipe = recipe
        self.setupMethod()
    }
    
    init(steps: [BakingStep], recipe: BreadRecipe, finishTime: Date) {
        self.id = UUID()
        self.steps = steps
        self.recipe = recipe
        self.setupMethod()
        self.futureStart(finishTime: finishTime)
    }
    
    mutating func futureStart(finishTime: Date) {
        let totalMinutes = steps.map({$0.lengthInMinutes}).reduce(0, +)
        startTime = Date(timeInterval: Double(-totalMinutes * 60), since: finishTime)
    }
    
    mutating func setupMethod() {
        if steps.count > 0 {
            if let makeOffset = steps.firstIndex(where: {$0.type == .makedough}) {
                let oldData = steps[makeOffset].data
                steps[makeOffset] = BakingStep(title: oldData.title, lengthInMinutes: oldData.lengthInMinutes, description: recipe.method, type: .makedough)
            }
            stepCompleted = [Bool](repeating: false, count: steps.count)
            nextAction = Date(timeInterval: TimeInterval(steps[0].lengthInMinutes * 60), since: startTime)
            updateStarts()
        }
    }
    
    mutating func updateStarts() {
        var currentStart = Date()
        if steps.count > 0 {
            for (index, step) in steps.enumerated() {
                if stepCompleted[index] {
                    continue
                }
                startArray.indices.contains(index) ? startArray[index] = currentStart : startArray.append(currentStart)
                currentStart = Date(timeInterval: TimeInterval(step.lengthInMinutes * 60), since: currentStart)
            }
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
