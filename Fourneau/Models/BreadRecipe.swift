//
//  BreadRecipe.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import Foundation

struct BreadRecipe: Codable, Identifiable, Equatable {
    let id: UUID
    var title: String
    var bakeTempF: Int
    var bakeTimeInMinutes: Int
    var ingredients: [String]
    var description: String
    let locked: Bool
    
    init(id: UUID = UUID(), title: String, bakeTempF: Int, bakeTimeInMinutes: Int, ingredients: [String], description: String, locked: Bool = false){
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
        var ingredients: [String] = []
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
    static let sampleRecipe = BreadRecipe(title: "White Sourdough", bakeTempF: 500, bakeTimeInMinutes: 50, ingredients: ["340 g Water","120 g Starter", "450 g Bread Flour","11 g Salt"], description: "A simple white sourdough to begin", locked: true)
    static let sampleRecipeList = [sampleRecipe, BreadRecipe(title: "Whole Wheat", bakeTempF: 500, bakeTimeInMinutes: 50, ingredients: ["340 g Water","120 g Starter", "450 g Bread Flour", "11 g Salt"], description: "A whole wheat for the next step")]
}
