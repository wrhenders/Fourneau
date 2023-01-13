//
//  RecipeDescription.swift
//  Fourneau
//
//  Created by Ryan Henderson on 1/6/23.
//

import SwiftUI

struct RecipeDescription: View {
    let recipe: BreadRecipe
    
    var body: some View {
        VStack(alignment: .leading) {



                Text("Time: \(Int(recipe.bakeTimeInMinutes)) Min")
                    .font(.headline)
            
            Divider()

            Text("Ingredients:").bold()
            ForEach(recipe.ingredients.ingredientList, id: \.self) {line in
                Text(line)
            }
            
            Divider()
            Text("Bake at: \(recipe.bakeTempF) F")
                .font(.headline)
        }
        
    }
}

struct RecipeDescription_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDescription(recipe: BreadRecipe.sampleRecipe)
    }
}
