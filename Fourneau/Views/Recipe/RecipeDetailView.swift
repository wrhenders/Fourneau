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
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                Image("bread")
                    .resizable()
                    .scaledToFit()
                VStack(alignment: .leading, spacing: 20) {
                    HStack{
                        Text("Bake at: \(recipe.bakeTempF) F")
                            .font(.headline)
                        Spacer()
                        Text("Time: \(Int(recipe.bakeTimeInMinutes)) Min")
                            .font(.headline)
                    }
                    Text("Ingredients:")
                        .font(.headline)
                    VStack(alignment: .leading, spacing:5) {
                        ForEach(recipe.ingredients, id: \.self) {line in
                            Text(line)
                        }
                    }
                    HStack{
                        Button("Choose") {
                            store.storeData.chosenRecipe = recipe
                            appState.rootViewId = UUID()
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: 640, alignment: .center)
            }
        }
        //.edgesIgnoringSafeArea(.top)
        .navigationTitle(recipe.title)
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
                        ToolbarItem(placement: .bottomBar) {
                            Button("Cancel") {
                                isRecipeEditViewShown = false
                            }
                        }
                        ToolbarItem(placement: .bottomBar) {
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
