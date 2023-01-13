//
//  RecipeDetailView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/7/22.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: BreadRecipe
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var store: BakingStore
    
    @State private var isRecipeEditViewShown = false
    @State private var data = BreadRecipe.Data()
    @State private var showingAlert = false
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack(spacing:0) {
            Image("bread")
                .resizable()
                .aspectRatio(contentMode: .fit)
            List {
                Section(header: HStack{ Text("Temp");Spacer(); Text("Time")}) {
                    HStack{
                        Text("Bake at: \(recipe.bakeTempF) F")
                            .font(.headline)
                        Spacer()
                        Text("Time: \(Int(recipe.bakeTimeInMinutes)) Min")
                            .font(.headline)
                    }
                }
                Section(header:Text("Ingredients:")) {
                    VStack(alignment: .leading) {
                        ForEach(recipe.ingredients.ingredientList, id: \.self) {line in
                            Text(line)
                        }
                    }
                }
                RecipeSummary(recipe: recipe.ingredients)
                Button("Choose") {
                    store.storeData.chosenRecipe = recipe
                    appState.rootViewId = UUID()
                }
                .font(.title2)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity)
                .buttonStyle(.plain)
                .listRowBackground(Color.darkOrange)
            }
        }
        .navigationTitle(recipe.title)
        .defaultNavigation
        .toolbar{
            Button("Edit") {
                if recipe.locked {
                    showingAlert = true
                } else {
                    data = recipe.data
                    isRecipeEditViewShown = true
                }
            }
        }
        .alert(isPresented: $showingAlert){
            Alert(
                title: Text("This is a Fourneau Recipe"),
                message: Text("If you would like to make edits, you can make a copy"),
                primaryButton: .destructive(Text("No Thanks")) {
                    showingAlert = false
                },
                secondaryButton: .default(Text("Copy")) {
                    data = recipe.data
                    isRecipeEditViewShown = true
                }
            )
        }
        .sheet(isPresented: $isRecipeEditViewShown) {
            NavigationView {
                EditRecipeView(recipe: $data)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isRecipeEditViewShown = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                if recipe.locked {
                                    store.storeData.recipeList.append(BreadRecipe(data: data))
                                    isRecipeEditViewShown = false
                                    dismiss()
                                } else {
                                    isRecipeEditViewShown = false
                                    recipe.update(from: data)
                                }
                            }
                        }
                }
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @State var breadRecipe = BreadRecipe.sampleRecipe
        @StateObject var store = BakingStore()
        @StateObject var appState = AppState()
        
        var body: some View {
            RecipeDetailView(recipe: $breadRecipe)
                .environmentObject(appState)
                .environmentObject(store)
        }
    }
    static var previews: some View {
        NavigationStack{
            BindingTestHolder()
        }
    }
}
