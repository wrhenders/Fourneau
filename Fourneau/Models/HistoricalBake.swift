//
//  HistoricalBake.swift
//  Fourneau
//
//  Created by Ryan Henderson on 1/4/23.
//

import Foundation

struct HistoricalBake: Codable, Identifiable {
    let id: UUID
    let method: BreadRecipeMethod
    let recipe: BreadRecipe
    let dateCompleted: Date
    
    var totalMinutes: Int {
        method.steps.count > 0 ?
        method.steps.map({$0.lengthInMinutes}).reduce(0, +) :
        0
    }
    
    init(method: BreadRecipeMethod, recipe: BreadRecipe) {
        self.id = UUID()
        self.method = method
        self.recipe = recipe
        self.dateCompleted = Date()
    }
}

extension HistoricalBake {
    static let sampleHistory = HistoricalBake(method: BreadRecipeMethod(), recipe: BreadRecipe.sampleRecipe)
}
