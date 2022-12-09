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
                        RecipeRow(recipe: recipeRow)
                            .onTapGesture {
                                recipe = recipeRow
                            }
                        NavigationLink(destination: RecipeDetailView(recipe: $recipeRow)) {
                            Text("")
                        }
                    }
                    .listRowBackground(recipe == recipeRow ? Color(red: 237/255, green: 213/255, blue: 140/255) : Color.white)
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
        .navigationTitle("Recipe List")
        .sheet(isPresented: $addingRecipe) {
            NavigationView {
                EditRecipeView(recipe: $data)
                    .navigationTitle(data.title)
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            Button("Cancel") {
                                addingRecipe = false
                            }
                        }
                        ToolbarItem(placement: .bottomBar) {
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
