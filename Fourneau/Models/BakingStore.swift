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
    
    @Published var methodList: [BreadRecipeMethod] = [BreadRecipeMethod(recipe: BreadRecipe.sampleRecipe)]
    @Published var chosenMethod: BreadRecipeMethod = BreadRecipeMethod(recipe: BreadRecipe.sampleRecipe)
}
