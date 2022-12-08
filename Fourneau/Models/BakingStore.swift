//
//  BakingStore.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/8/22.
//

import Foundation
import SwiftUI

class BakingStore: ObservableObject {
    @Published var recipeList: [BreadRecipe] = BreadRecipe.sampleRecipeList
    @Published var chosenRecipe: BreadRecipe = BreadRecipe.sampleRecipe
    
    @Published var methodList: [BreadRecipeMethod] = [BreadRecipeMethod()]
    @Published var chosenMethod: BreadRecipeMethod = BreadRecipeMethod()
    
    var completedRecipe: CompletedRecipe {
        CompletedRecipe(title: chosenMethod.title, steps: chosenMethod.steps, recipe: chosenRecipe)
    }
}
