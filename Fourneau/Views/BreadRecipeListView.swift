//
//  BreadRecipeListView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/7/22.
//

import SwiftUI

struct BreadRecipeListView: View {
    @State var breadRecipeList: [BreadRecipe] = BreadRecipe.sampleRecipeList
    @State var chosenRecipe: BreadRecipe?
    @State var addingRecipe = false
    @State private var data = BreadRecipe.Data()
    
    var body: some View {
        List {
            Section{
                ForEach($breadRecipeList) { $recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: $recipe)) {
                        RecipeRow(recipe: recipe)
                    }
                    .onTapGesture {
                        self.chosenRecipe = recipe
                    }
                    .listRowBackground(self.chosenRecipe == recipe ? Color(red: 237/255, green: 213/255, blue: 140/255) : Color.white)
                }
                .onDelete { indicies in
                    breadRecipeList.remove(atOffsets: indicies)
                }
                Button(action: {
                    addingRecipe = true
                }) {
                    Label("Add New Recipe", systemImage: "plus.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            Section {
                NavigationLink(destination: {}) {
                    Text("Choose Baking Steps")
                        .font(.title2)
                        .foregroundColor(Color.blue)
                }
            }
        }
        .navigationTitle("Recipe List")
        .sheet(isPresented: $addingRecipe) {
            NavigationView {
                EditRecipeView(recipe: $data)
                    .navigationTitle(data.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                addingRecipe = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                addingRecipe = false
                                breadRecipeList.append(BreadRecipe(data: data))
                                data = BreadRecipe.Data()
                            }
                        }
                }
            }
        }
    }
}

struct BreadRecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            BreadRecipeListView()
        }
    }
}
