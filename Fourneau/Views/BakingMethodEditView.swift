//
//  BakingMethodEditView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/6/22.
//

import SwiftUI

struct BakingMethodEditView: View {
    @Binding var breadMethod : BreadRecipeMethod
    
    var body: some View {
        Form {
            Section(header: Text("Title")){
                TextField("Title", text: $breadMethod.title)
            }
            Section(header: Text("Baking Steps")){
                ForEach($breadMethod.steps) { $step in
                    EditStepView(step: $step)
                    .onDrag {
                        return NSItemProvider()
                    }
                }
                HStack {
                    Spacer()
                    Text("Add Step")
                    Button(action: {}) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
    }
}

struct BakingMethodEditView_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @State var breadMethod = BreadRecipeMethod(recipe: BreadRecipe.sampleRecipe)
        var body: some View {
            BakingMethodEditView(breadMethod: $breadMethod)
        }
    }
    static var previews: some View {
        NavigationStack{
            BindingTestHolder()
        }
    }
}
