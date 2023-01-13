//
//  EditRecipeView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/7/22.
//

import SwiftUI

struct EditRecipeView: View {
    @Binding var recipe: BreadRecipe.Data
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Step Title", text: $recipe.title)
                    .font(.title2)
            }
            Section(header: Text("Time and Temp")) {
                HStack{
                    Text("Minutes:")
                    TextField("Min", value: $recipe.bakeTimeInMinutes, format:.number)
                        .font(.title2)
                }
                HStack {
                    Text("Bake Temp (F):")
                    TextField("Temp", value: $recipe.bakeTempF, format:.number)
                        .font(.title2)
                }
            }
            Section(header: Text("Short Description:")) {
                TextField("Description", text: $recipe.description, axis: .vertical)
                    .font(.title3)
            }
            EditRecipeIngredients(recipe: $recipe.ingredients)
        }
    }
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeView(recipe: .constant(BreadRecipe.sampleRecipe.data))
    }
}
