//
//  BakingMethodListView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/8/22.
//

import SwiftUI

struct BakingMethodListView: View {
    @Binding var recipe: BreadRecipe?
    @State var bakingMethodList : [BreadRecipeMethod] = []
    
    
    var body: some View {
        let checkedRecipe = recipe ?? BreadRecipe(data: BreadRecipe.Data())
        let emptyMethod = BreadRecipeMethod(title: "Edit", steps: [], recipe: checkedRecipe)
        
        List {
            ForEach($bakingMethodList) {$method in
                NavigationLink(destination: BakingMethodDetailView(breadMethod: $method)) {
                    Text(method.title)
                        .font(.title2)
                }
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
        .onAppear {
            bakingMethodList.append(BreadRecipeMethod(recipe: checkedRecipe))
        }
    }
}

struct BakingMethodListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            BakingMethodListView(recipe: .constant(BreadRecipe.sampleRecipe))
        }
    }
}
