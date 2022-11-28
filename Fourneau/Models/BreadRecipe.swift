//
//  BreadRecipe.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import Foundation

struct BreadRecipe: Codable, Identifiable {
    let id: UUID
    let title: String
    let bakeTempF: Int
    let bakeTimeInMinutes: Double
    let method: String
    
    init(id: UUID = UUID(), title: String, bakeTempF: Int, bakeTimeInMinutes: Double, method: String){
        self.id = id
        self.title = title
        self.bakeTempF = bakeTempF
        self.bakeTimeInMinutes = bakeTimeInMinutes
        self.method = method
    }
}

extension BreadRecipe {
    static let sampleRecipe = BreadRecipe(title: "White Sourdough", bakeTempF: 500, bakeTimeInMinutes: 50, method: "Combine:\n340 g Water\n120 g Satrter\n450 g Bread Flour\nLet sit 15 minutes\nAdd 11 g Salt\nMix until homogeneous")
}
