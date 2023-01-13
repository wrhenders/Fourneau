//
//  RecipeCalculatorView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/19/22.
//

import SwiftUI

struct RecipeCalculatorView: View {
    @EnvironmentObject var store: BakingStore
    @EnvironmentObject var appState: AppState
    
    @State private var recipe: RecipeIngredients = RecipeIngredients(flours: [Ingredient(name: "AP", weight: 450)], waterWeight: 340, saltWeight: 11, leavenWeight: 120, sourdough: true)
    
    @State var recipeData = BreadRecipe.Data()
    @State var isPresentingRecipeView = false
    
    var body: some View {
        NavigationView {
            ZStack{
                List {
                    RecipeSummary(recipe: recipe)
                }
                List{
                    EditRecipeIngredients(recipe: $recipe)
                    Button("Save") {
                        recipeData.ingredients = RecipeIngredients()
                        isPresentingRecipeView = true
                    }
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.plain)
                    .listRowBackground(Color.darkOrange)
                }
                .padding(.top, 225)
                .padding(.bottom, 1)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Recipe Calculator")
        .defaultNavigation
        .sheet(isPresented: $isPresentingRecipeView) {
            NavigationView {
                EditRecipeView(recipe: $recipeData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingRecipeView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                let newRecipe = BreadRecipe(data: recipeData)
                                store.storeData.recipeList.append(newRecipe)
                                isPresentingRecipeView = false
                                appState.tabSelection = Tab.summary
                            }
                        }
                    }
            }
        }
    }
}

struct RecipeCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
            RecipeCalculatorView()
    }
}
