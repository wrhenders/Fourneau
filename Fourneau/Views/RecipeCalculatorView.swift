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
    @State private var flourWeight: [IngredientWeight] = [IngredientWeight(name: "Ap", amount: 450)]
    @State private var waterWeight: Int = 340
    @State private var leavenWeight: Int = 120
    @State private var saltWeight: Int = 11
    
    private var totalFlour: Int {
        return flourWeight.map{$0.amount}.reduce(0, +) + (leavenWeight / 2)
    }
    private var totalWater: Int {
        return waterWeight + (leavenWeight / 2)
    }
    
    var body: some View {
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
                Button("Save") {
                    
                }
            }
        }
        .navigationTitle("Recipe Calculator")
    }
}

struct RecipeCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RecipeCalculatorView()
        }
    }
}
