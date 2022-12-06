//
//  BakingMethodView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/6/22.
//

import SwiftUI

struct BakingMethodView: View {
    @Binding var breadMethod : BreadRecipeMethod
    
    var body: some View {
        List {
            Section(header: Text("Baking Steps (Hold to reorder)")){
                ForEach(breadMethod.steps) { step in
                    VStack {
                        Text(step.title)
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            Text("Minutes: \(Int(step.lengthInMinutes))")
                            Spacer()
                            Text("Type: \(step.type.title)")
                        }
                    }
                    .onDrag {
                        return NSItemProvider()
                    }
                }
                .onMove(perform: move)
                HStack {
                    Spacer()
                    Text("Add Step")
                    Button(action: {}) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
        .navigationBarTitle(breadMethod.title)
        .toolbar {
            NavigationLink(destination: BakingStepListView(breadMethod: $breadMethod)){
                Image(systemName: "chevron.right")
            }
        }
        
    }
    
    func move(from source: IndexSet, to destination: Int){
        breadMethod.steps.move(fromOffsets: source, toOffset: destination)
    }
}


struct BakingMethodView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            BakingMethodView(breadMethod: .constant(BreadRecipeMethod(recipe: BreadRecipe.sampleRecipe)) )
        }
    }
}
