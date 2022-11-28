//
//  RecipeTimer.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import Foundation

class RecipeTimer: ObservableObject {
    @Published private var startTimes: [Date] = []
    
    private(set) var recipe: BreadRecipeSteps
    private(set) var startTime: Date
    
    init(recipe: BreadRecipeSteps, startTime: Date = Date()) {
        self.recipe = recipe
        self.startTime = startTime
    }

}
