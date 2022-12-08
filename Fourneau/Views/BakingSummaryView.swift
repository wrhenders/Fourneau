//
//  BakingSummaryView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/8/22.
//

import SwiftUI

struct BakingSummaryView: View {
    @ObservedObject var store: BakingStore
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("bread")
                .resizable()
                .scaledToFit()
            List {
                Section(header: Text("Recipe")) {
                    NavigationLink(destination: BreadRecipeListView(recipe: $store.chosenRecipe, recipeList: $store.recipeList)){
                        Text(store.chosenRecipe.title)
                    }
                }
                Section(header: Text("Method")) {
                    NavigationLink(destination: BakingMethodListView(chosenMethod: $store.chosenMethod, bakingMethodList: $store.methodList, recipe: BreadRecipe.sampleRecipe)) {
                        Text(store.chosenMethod.title)
                    }
                }
                Section {
                    NavigationLink(destination: {BakingStepListView(completedRecipe: store.completedRecipe)}) {
                        Text("Bake")
                            .font(.title2)
                            .foregroundColor(Color.blue)
                    }
                }
            }
        }
        .navigationTitle("Baking Summary")
    }
}

struct BakingSummaryView_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @StateObject var store = BakingStore()
        var body: some View {
            BakingSummaryView(store: store)
        }
    }
    static var previews: some View {
        NavigationStack {
            BindingTestHolder()
        }
    }
}
