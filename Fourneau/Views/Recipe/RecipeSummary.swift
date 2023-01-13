//
//  RecipeSummary.swift
//  Fourneau
//
//  Created by Ryan Henderson on 1/13/23.
//

import SwiftUI

struct RecipeSummary: View {
    var recipe: RecipeIngredients
    
    var body: some View {
        Section(header:Text("Recipe Summary")) {
            HStack{
                Text("Weights:").bold()
                Spacer()
                Text("Bakers %")
            }
            .listRowBackground(Color.listSelection)
            HStack {
                Text("Total Flour: \(recipe.totalFlour) g")
                Spacer()
                Text("100 %")
            }
            HStack {
                Text("Total Water: \(recipe.totalWater) g")
                Spacer()
                Text("\(String(format: "%.2f", Double(recipe.totalWater) / Double(recipe.totalFlour) * 100)) %")
            }
            HStack {
                Text("Total Salt: \(recipe.saltWeight) g")
                Spacer()
                Text("\(String(format: "%.2f", Double(recipe.saltWeight) / Double(recipe.totalFlour) * 100)) %")
            }
        }
    }
}

struct RecipeSummary_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RecipeSummary(recipe: BreadRecipe.sampleIngredients)
        }
    }
}
