//
//  BakingMethodView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/6/22.
//

import SwiftUI

struct BakingMethodDetailView: View {
    @Binding var breadMethodData : BreadRecipeMethod.Data
    
    @State private var isPresentingEditView = false
    @State private var data = BakingStep.Data()
    @State private var updateIndex = 0
    
    var body: some View {
        List {
            Section(header: Text("Title")) {
                TextField("Title", text: $breadMethodData.title)
                    .font(.headline)
            }
            Section(header: Text("Baking Steps")){
                ForEach(Array(breadMethodData.steps.enumerated()), id: \.element) { index, step in
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
                    breadMethodData.steps.remove(atOffsets: indicies)
                }
                Button(action: {
                    breadMethodData.steps.append(BakingStep(data: data))
                    updateIndex = breadMethodData.steps.count - 1
                    isPresentingEditView = true
                    
                }) {
                    Label("Add Step", systemImage: "plus.circle.fill")
                }
            }
        }
        .navigationBarTitle(breadMethodData.title)
        .toolbar{ EditButton() }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                EditStepView(step: $data)
                    .navigationTitle(data.title)
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            Button("Cancel") {
                                isPresentingEditView = false
                                data = BakingStep.Data()
                            }
                        }
                        ToolbarItem(placement: .bottomBar) {
                            Button("Done") {
                                isPresentingEditView = false
                                if breadMethodData.steps.indices.contains(updateIndex) {
                                    breadMethodData.steps[updateIndex] = BakingStep(data: data)
                                }
                                data = BakingStep.Data()
                                updateIndex = 0
                            }
                        }
                    }
            }
        }
        
    }
    
    func move(from source: IndexSet, to destination: Int){
        breadMethodData.steps.move(fromOffsets: source, toOffset: destination)
    }
}


struct BakingMethodDetailView_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @State var breadMethod = BreadRecipeMethod().data
        var body: some View {
            BakingMethodDetailView(breadMethodData: $breadMethod)
        }
    }
    static var previews: some View {
        NavigationStack{
            BindingTestHolder()
        }
    }
}
