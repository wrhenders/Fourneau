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
    var method: [String]
    var description: String
    
    init(id: UUID = UUID(), title: String, bakeTempF: Int, bakeTimeInMinutes: Int, method: [String], description: String){
        self.id = id
        self.title = title
        self.bakeTempF = bakeTempF
        self.bakeTimeInMinutes = bakeTimeInMinutes
        self.method = method
        self.description = description
    }
    
    struct Data {
        var title: String = ""
        var bakeTempF: Int = 350
        var bakeTimeInMinutes: Int = 0
        var method: [String] = []
        var description: String = ""
    }
    
    var data: Data {
        Data(title: title, bakeTempF: bakeTempF, bakeTimeInMinutes: bakeTimeInMinutes, method: method, description: description)
    }
    
    init(data: Data) {
        id = UUID()
        title = data.title
        bakeTempF = data.bakeTempF
        bakeTimeInMinutes = data.bakeTimeInMinutes
        method = data.method
        description = data.description
    }
    
    mutating func update(from data: Data) {
        title = data.title
        title = data.title
        bakeTempF = data.bakeTempF
        bakeTimeInMinutes = data.bakeTimeInMinutes
        method = data.method
        description = data.description
    }
}

extension BreadRecipe {
    static let sampleRecipe = BreadRecipe(title: "White Sourdough", bakeTempF: 500, bakeTimeInMinutes: 50, method: ["Combine:","340 g Water","120 g Satrter", "450 g Bread Flour", "Let sit 15 minutes", "Add 11 g Salt", "Mix until homogeneous"], description: "A simple white sourdough to begin")
    static let sampleRecipeList = [sampleRecipe, BreadRecipe(title: "Whole Wheat", bakeTempF: 500, bakeTimeInMinutes: 50, method: ["Combine:","340 g Water","120 g Satrter", "450 g Bread Flour", "Let sit 15 minutes", "Add 11 g Salt", "Mix until homogeneous"], description: "A whole wheat for the next step")]
}
