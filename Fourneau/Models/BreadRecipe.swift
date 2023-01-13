//
//  BreadRecipe.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import Foundation

struct Ingredient: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var weight: Int
}

struct RecipeIngredients: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var flours: [Ingredient] = []
    var waterWeight: Int = 0
    var saltWeight: Int = 0
    var leavenWeight: Int = 0
    var sourdough: Bool = true
    var additionalIngredients: [Ingredient] = []
    
    var totalFlour: Int {
        let weight = flours.map{$0.weight}.reduce(0, +)
        return sourdough ?
            weight + (leavenWeight / 2) :
            weight
    }
    var totalWater: Int {
        return sourdough ?
        waterWeight + (leavenWeight / 2) :
        waterWeight
    }
    var ingredientList: [String] {
        var ingredients: [String] = []
        for flour in flours  {
            ingredients.append("\(flour.weight) g \(flour.name)")
        }
        ingredients.append("\(waterWeight) g Water")
        ingredients.append("\(leavenWeight) g Starter")
        ingredients.append("\(saltWeight) g Salt")
        for ing in additionalIngredients {
            ingredients.append("\(ing.weight) g \(ing.name)")
        }
        return ingredients
    }
}

struct BreadRecipe: Codable, Identifiable, Equatable {
    let id: UUID
    var title: String
    var bakeTempF: Int
    var bakeTimeInMinutes: Int
    var ingredients: RecipeIngredients
    var description: String
    let locked: Bool
    
    init(id: UUID = UUID(), title: String, bakeTempF: Int, bakeTimeInMinutes: Int,
         ingredients: RecipeIngredients, description: String, locked: Bool = false){
        self.id = id
        self.title = title
        self.bakeTempF = bakeTempF
        self.bakeTimeInMinutes = bakeTimeInMinutes
        self.ingredients = ingredients
        self.description = description
        self.locked = locked
    }
    
    struct Data {
        var title: String = ""
        var bakeTempF: Int = 350
        var bakeTimeInMinutes: Int = 0
        var ingredients: RecipeIngredients = RecipeIngredients()
        var description: String = ""
    }
    
    var data: Data {
        Data(title: title, bakeTempF: bakeTempF, bakeTimeInMinutes: bakeTimeInMinutes, ingredients: ingredients, description: description)
    }
    
    init(data: Data) {
        id = UUID()
        title = data.title
        bakeTempF = data.bakeTempF
        bakeTimeInMinutes = data.bakeTimeInMinutes
        ingredients = data.ingredients
        description = data.description
        locked = false
    }
    
    mutating func update(from data: Data) {
        title = data.title
        title = data.title
        bakeTempF = data.bakeTempF
        bakeTimeInMinutes = data.bakeTimeInMinutes
        ingredients = data.ingredients
        description = data.description
    }
}

extension BreadRecipe {
    static let sampleIngredients = RecipeIngredients(flours: [Ingredient(name: "Bread Flour", weight: 450)], waterWeight: 340, saltWeight: 11, leavenWeight: 120, sourdough: true)
    static let sampleRecipe = BreadRecipe(title: "White Sourdough", bakeTempF: 500, bakeTimeInMinutes: 50, ingredients: sampleIngredients, description: "A simple white sourdough to begin", locked: true)
    static let sampleRecipeList = [sampleRecipe, BreadRecipe(title: "Whole Wheat", bakeTempF: 500, bakeTimeInMinutes: 50, ingredients: sampleIngredients, description: "A whole wheat for the next step")]
}
