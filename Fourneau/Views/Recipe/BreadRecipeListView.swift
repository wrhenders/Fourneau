//
//  BreadRecipeListView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/7/22.
//

import SwiftUI

struct BreadRecipeListView: View {
    @Binding var recipe: BreadRecipe
    @Binding var recipeList: [BreadRecipe]
    
    @State var addingRecipe = false
    @State private var data = BreadRecipe.Data()
    
    var body: some View {
        List {
            Section{
                ForEach($recipeList) { $recipeRow in
                    ZStack(alignment: .leading) {
                        NavigationLink(destination: RecipeDetailView(recipe: $recipeRow)) {
                            RecipeRow(recipe: recipeRow)
                        }
                    }
                    .listRowBackground(recipe == recipeRow ? Color.listSelection : Color.white)
                    .deleteDisabled(recipeRow.locked)
                }
                .onDelete { indicies in
                    recipeList.remove(atOffsets: indicies)
                }
                Button(action: {
                    addingRecipe = true
                }) {
                    Label("Add New Recipe", systemImage: "plus.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .listStyle(.grouped)
        .navigationTitle("Recipe Ingredients")
        .defaultNavigation
        .sheet(isPresented: $addingRecipe) {
            NavigationView {
                EditRecipeView(recipe: $data)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                addingRecipe = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                addingRecipe = false
                                recipeList.append(BreadRecipe(data: data))
                                data = BreadRecipe.Data()
                            }
                        }
                }
            }
        }
    }
}

struct BreadRecipeListView_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @State var recipe = BreadRecipe.sampleRecipe
        @State var recipeList = BreadRecipe.sampleRecipeList
        
        var body: some View {
            BreadRecipeListView(recipe: $recipe, recipeList: $recipeList)
        }
    }
    static var previews: some View {
        NavigationView{
            BindingTestHolder()
        }
    }
}
