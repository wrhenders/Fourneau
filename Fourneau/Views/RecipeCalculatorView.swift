//
//  RecipeCalculatorView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/19/22.
//

import SwiftUI

struct IngredientWeight {
    let id: UUID = UUID()
    var name: String
    var amount: Int
}

struct RecipeCalculatorView: View {
    @EnvironmentObject var store: BakingStore
    @EnvironmentObject var appState: AppState
    
    @State private var flourWeight: [IngredientWeight] = [IngredientWeight(name: "AP", amount: 450)]
    @State private var waterWeight: Int = 340
    @State private var leavenWeight: Int = 120
    @State private var saltWeight: Int = 11
    
    @State var recipeData = BreadRecipe.Data()
    @State var isPresentingRecipeView = false
    
    
    private var totalFlour: Int {
        return flourWeight.map{$0.amount}.reduce(0, +) + (leavenWeight / 2)
    }
    private var totalWater: Int {
        return waterWeight + (leavenWeight / 2)
    }
    
    private func ingredientList() -> [String] {
        var ingredients: [String] = []
        for flour in flourWeight  {
            ingredients.append("\(flour.amount) g \(flour.name)")
        }
        ingredients.append("\(waterWeight) g Water")
        ingredients.append("\(leavenWeight) g Starter")
        ingredients.append("\(saltWeight) g Salt")
        return ingredients
    }
    
    var body: some View {
        NavigationView {
            List{
                Section(header: HStack{ Text("Flour");Spacer(); Text("Amount")}) {
                    ForEach($flourWeight, id: \.self.id) { $flour in
                        HStack {
                            TextField("Flour", text: $flour.name)
                                .multilineTextAlignment(.leading)
                            TextField("Amount", value: $flour.amount, format: .number)
                                .multilineTextAlignment(.trailing)
                            Text("g")
                        }
                    }
                    .onDelete { indicies in
                        flourWeight.remove(atOffsets: indicies)
                    }
                    Button(action: {
                        let newFlour = IngredientWeight(name: "", amount: 0)
                        flourWeight.append(newFlour)
                        
                    }) {
                        Label("Add Flour", systemImage: "plus.circle.fill")
                    }
                }
                Section(header: Text("Water")) {
                    HStack {
                        Text("Water")
                        TextField("Amount", value: $waterWeight, format: .number)
                            .multilineTextAlignment(.trailing)
                        Text("g")
                    }
                }
                Section(header: Text("Leaven (100% Hydration assumed)")) {
                    HStack {
                        Text("Starter")
                        TextField("Amount", value: $leavenWeight, format: .number)
                            .multilineTextAlignment(.trailing)
                        Text("g")
                    }
                }
                Section(header: Text("Salt")) {
                    HStack {
                        Text("Salt")
                        TextField("Amount", value: $saltWeight, format: .number)
                            .multilineTextAlignment(.trailing)
                        Text("g")
                    }
                }
                Section(header:Text("Recipe Summary")) {
                    HStack{
                        Text("Weights:").bold()
                    }
                    .listRowBackground(Color.listSelection)
                    HStack {
                        Text("Total Flour: \(totalFlour) g")
                        Spacer()
                        Text("100 %")
                    }
                    HStack {
                        Text("Total Water: \(totalWater) g")
                        Spacer()
                        Text("\(String(format: "%.2f", Double(totalWater) / Double(totalFlour) * 100)) %")
                    }
                    HStack {
                        Text("Total Salt: \(saltWeight) g")
                        Spacer()
                        Text("\(String(format: "%.2f", Double(saltWeight) / Double(totalFlour) * 100)) %")
                    }
                }
                
                HStack {
                    Button (action: {
                        recipeData.ingredients = ingredientList()
                        isPresentingRecipeView = true
                    }) {
                        Text("Save")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
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
}

struct RecipeCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
            RecipeCalculatorView()
    }
}
