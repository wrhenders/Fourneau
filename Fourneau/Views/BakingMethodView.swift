//
//  BakingMethodView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/6/22.
//

import SwiftUI

struct BakingMethodView: View {
    @Binding var breadMethod : BreadRecipeMethod
    
    @State private var isPresentingEditView = false
    @State private var data = BakingStep.Data()
    @State private var updateIndex = 0
    
    var body: some View {
        List {
            Section(header: Text("Baking Steps")){
                ForEach(Array(breadMethod.steps.enumerated()), id: \.element) { index, step in
                        VStack {
                            Button(action:{
                                data = step.data
                                updateIndex = index
                                isPresentingEditView = true
                            }) {
                                Text(step.title)
                                    .font(.title3)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        HStack {
                            Text("Minutes: \(Int(step.lengthInMinutes))")
                            Spacer()
                            Text("Type: \(step.type.title)")
                        }
                    }
                }
                .onMove(perform: move)
                .onDelete { indicies in
                    breadMethod.removeStep(atOffset: indicies)
                }
                Button(action: {
                    updateIndex = breadMethod.steps.count - 1
                    isPresentingEditView = true
                    
                }) {
                    Label("Add Step", systemImage: "plus.circle.fill")
                }
            }
        }
        .navigationBarTitle(breadMethod.title)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                NavigationLink(destination: BakingStepListView(breadMethod: $breadMethod)){
                    Image(systemName: "chevron.right")
                }
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                EditStepView(step: $data)
                    .navigationTitle(data.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                breadMethod.updateStep(from: data, at: updateIndex)
                                data = BakingStep.Data()
                                updateIndex = 0
                            }
                        }
                    }
            }
        }
        
    }
    
    func move(from source: IndexSet, to destination: Int){
        breadMethod.steps.move(fromOffsets: source, toOffset: destination)
    }
}


struct BakingMethodView_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @State var breadMethod = BreadRecipeMethod(recipe: BreadRecipe.sampleRecipe)
        var body: some View {
            BakingMethodView(breadMethod: $breadMethod)
        }
    }
    static var previews: some View {
        NavigationStack{
            BindingTestHolder()
        }
    }
}
