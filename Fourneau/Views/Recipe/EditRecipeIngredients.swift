//
//  EditRecipeIngredients.swift
//  Fourneau
//
//  Created by Ryan Henderson on 1/13/23.
//

import SwiftUI

struct EditRecipeIngredients: View {
    @Binding var recipe: RecipeIngredients
    
    var body: some View {
        Section(header: HStack{ Text("Flour");Spacer(); Text("Weight")}) {
            ForEach($recipe.flours, id: \.self.id) { $flour in
                HStack {
                    TextField("Flour", text: $flour.name)
                        .multilineTextAlignment(.leading)
                    TextField("Weight", value: $flour.weight, format: .number)
                        .multilineTextAlignment(.trailing)
                    Text("g")
                }
            }
            .onDelete { indicies in
                recipe.flours.remove(atOffsets: indicies)
            }
            Button(action: {
                let newFlour = Ingredient(name: "", weight: 0)
                recipe.flours.append(newFlour)
                
            }) {
                Label("Add Flour", systemImage: "plus.circle.fill")
            }
        }
        Section(header: Text("Water")) {
            HStack {
                Text("Water")
                TextField("Amount", value: $recipe.waterWeight, format: .number)
                    .multilineTextAlignment(.trailing)
                Text("g")
            }
        }
        Section(header: Text("Leaven")) {
            VStack{
                Picker("Sourdough", selection: $recipe.sourdough) {
                    Text("Sourdough").tag(true)
                    Text("Yeast").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                HStack {
                    Text(recipe.sourdough ? "Starter" : "Yeast")
                    TextField("Amount", value: $recipe.leavenWeight, format: .number)
                        .multilineTextAlignment(.trailing)
                    Text("g")
                }
                   }
        }
        Section(header: Text("Salt")) {
            HStack {
                Text("Salt")
                TextField("Amount", value: $recipe.saltWeight, format: .number)
                    .multilineTextAlignment(.trailing)
                Text("g")
            }
        }
        Section(header: HStack{ Text("Additional Ingredients");Spacer(); Text("Amount")}) {
            ForEach($recipe.additionalIngredients, id: \.self.id) { $ing in
                HStack {
                    TextField("Ingredient", text: $ing.name)
                        .multilineTextAlignment(.leading)
                    TextField("Weight", value: $ing.weight, format: .number)
                        .multilineTextAlignment(.trailing)
                    Text("g")
                }
            }
            .onDelete { indicies in
                recipe.additionalIngredients.remove(atOffsets: indicies)
            }
            Button(action: {
                let newIng = Ingredient(name: "", weight: 0)
                recipe.additionalIngredients.append(newIng)
            }) {
                Label("Add Ingredient", systemImage: "plus.circle.fill")
            }
        }
    }
}
