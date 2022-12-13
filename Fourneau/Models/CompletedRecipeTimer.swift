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
        print("Total Min: \(totalMinutes)")
        print("Now Start Time: \(startTime)")
        print("Now End Time: \(endTime)")
        print("Diff: \(endTime.timeIntervalSince(startTime) / 60)")
    }
    
    init(steps: [BakingStep], recipe: BreadRecipe, finishTime: Date) {
        self.id = UUID()
        self.steps = steps
        self.recipe = recipe
        self.endTime = finishTime
        self.setupMethod(futureTime: finishTime)
        print("Total Min: \(totalMinutes)")
        print("Future Start Time: \(startTime)")
        print("Future End Time: \(endTime)")
        print("Diff: \(endTime.timeIntervalSince(startTime) / 60)")
    }
    
    mutating func setupMethod(futureTime: Date?) {
        if steps.count > 0 {
            if let makeOffset = steps.firstIndex(where: {$0.type == .makedough}) {
                let oldData = steps[makeOffset].data
                steps[makeOffset] = BakingStep(title: oldData.title, lengthInMinutes: oldData.lengthInMinutes, description: recipe.method, type: .makedough)
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
}
