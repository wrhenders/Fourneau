//
//  BakingMethodListView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/8/22.
//

import SwiftUI

struct BakingMethodListView: View {
    @Binding var chosenMethod: BreadRecipeMethod
    @Binding var bakingMethodList: [BreadRecipeMethod]
    let recipe: BreadRecipe
    
    var body: some View {
        let emptyMethod = BreadRecipeMethod(title: "Edit", steps: [], recipe: recipe)
        
        List {
            ForEach($bakingMethodList) {$methodRow in
                NavigationLink(destination: BakingMethodDetailView(breadMethod: $methodRow)) {
                    Text(methodRow.title)
                        .font(.title2)
                }
                .onTapGesture {
                    chosenMethod = methodRow
                }
                .listRowBackground(chosenMethod == methodRow ? Color(red: 237/255, green: 213/255, blue: 140/255) : Color.white)
            }
            .onDelete { indicies in
                bakingMethodList.remove(atOffsets: indicies)
            }
            Button(action: {
                bakingMethodList.append(emptyMethod)
            }) {
                Label("Add New Method", systemImage: "plus.circle.fill")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Method")
    }
}

struct BakingMethodListView_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @State var breadMethod = BreadRecipeMethod(recipe: BreadRecipe.sampleRecipe)
        @State var methodList = [BreadRecipeMethod(recipe: BreadRecipe.sampleRecipe)]
        var body: some View {
            BakingMethodListView(chosenMethod: $breadMethod, bakingMethodList: $methodList, recipe: BreadRecipe.sampleRecipe)
        }
    }
    static var previews: some View {
        NavigationView{
            BindingTestHolder()
        }
    }
}
