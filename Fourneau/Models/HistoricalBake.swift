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
