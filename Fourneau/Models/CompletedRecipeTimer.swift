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
    var steps: [BakingStep]
    var recipe: BreadRecipe
    
    var stepCompleted: [Bool] = []
    var startArray: [Date] = []
    var nextAction: Date?
    var currentStep: Int = 0
    var endTime: Date = Date()
    var recipeCompleted: Bool = false
    var totalMinutes: Int {
        steps.count > 0 ?
            steps.map({$0.lengthInMinutes}).reduce(0, +) :
            0
    }
    
    init(steps: [BakingStep], recipe: BreadRecipe) {
        self.id = UUID()
        self.steps = steps
        self.recipe = recipe
        self.endTime = Date(timeInterval: (Double(self.totalMinutes) * 60), since: self.startTime)
        self.setupMethod(futureTime: nil)
    }
    
    init(steps: [BakingStep], recipe: BreadRecipe, finishTime: Date) {
        self.id = UUID()
        self.steps = steps
        self.recipe = recipe
        self.endTime = finishTime
        self.setupMethod(futureTime: finishTime)
    }
    
    mutating func setupMethod(futureTime: Date?) {
        if steps.count > 0 {
            if let makeOffset = steps.firstIndex(where: {$0.type == .makedough}) {
                var data = steps[makeOffset].data
                data.description = recipe.ingredients
                steps[makeOffset] = BakingStep(data: data)
            }
            if let bakeOffset = steps.firstIndex(where: {$0.type == .bake}) {
                var data = steps[bakeOffset].data
                data.temp = recipe.bakeTempF
                steps[bakeOffset] = BakingStep(data: data)
            }
            if futureTime != nil {
                let waitTime = Int(endTime.timeIntervalSince(startTime) / 60) - totalMinutes
                let waitStep = BakingStep(title: "Wait", lengthInMinutes: waitTime, type: .wait)
                steps.insert(waitStep, at: 0)
            }
            steps.append(BakingStep(title: "Finished", lengthInMinutes: 0, type: .done))
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
            endTime = Date(timeInterval: TimeInterval((steps.last!.lengthInMinutes * 60)), since: startArray.last!)
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
    
    func getStepArray() -> [BakingStep] {
        var cleanSteps: [BakingStep] = []
        
        for (index, step) in steps.enumerated() {
            let stepLength = startArray.indices.contains(index + 1) ?
                Int(startArray[index + 1].timeIntervalSince(startArray[index]) / 60) :
                0
            
            switch step.type {
            case .wait, .done:
                continue
            case .makedough:
                var data = steps[index].data
                data.description = []
                data.lengthInMinutes = stepLength
                cleanSteps.append(BakingStep(data: data))
            case .bake:
                var data = steps[index].data
                data.temp = nil
                data.lengthInMinutes = stepLength
                cleanSteps.append(BakingStep(data: data))
            default:
                var data = steps[index].data
                data.lengthInMinutes = stepLength
                cleanSteps.append(BakingStep(data: data))
            }
        }
        
        return cleanSteps
    }
}
