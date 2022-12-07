//
//  BreadRecipeListView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/7/22.
//

import SwiftUI

struct BreadRecipeListView: View {
    @State var breadRecipeList: [BreadRecipe] = BreadRecipe.sampleRecipeList
    @State var chosenRecipe: UUID?
    
    var body: some View {
        List {
            ForEach($breadRecipeList) { $recipe in
                NavigationLink(destination: RecipeDetailView(recipe: $recipe)) {
                    RecipeRow(recipe: recipe)
                }
                .onTapGesture {
                    self.chosenRecipe = recipe.id
                }
                .listRowBackground(self.chosenRecipe == recipe.id ? Color(red: 237/255, green: 213/255, blue: 140/255) : Color.white)
            }

        }
        .navigationTitle("Recipe List")
    }
}

struct BreadRecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            BreadRecipeListView()
        }
    }
}
