//
//  BakingMethodView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/6/22.
//

import SwiftUI

struct BakingMethodEditDetailView: View {
    @Binding var breadMethodData : BreadRecipeMethod.Data
    
    @State private var isPresentingEditView = false
    @State private var data = BakingStep.Data()
    @State private var updateId: UUID?
    
    var body: some View {
        List {
            Section(header: Text("Title")) {
                TextField("Title", text: $breadMethodData.title)
                    .font(.headline)
            }
            Section(header: Text("Baking Steps")){
                ForEach(breadMethodData.steps, id: \.self.id) { step in
                    VStack {
                            Button(action:{
                                data = step.data
                                updateId = step.id
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
                    let newStep = BakingStep(data: data)
                    updateId = newStep.id
                    breadMethodData.steps.append(newStep)
                    isPresentingEditView = true
                    
                }) {
                    Label("Add Step", systemImage: "plus.circle.fill")
                }
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                EditStepView(step: $data)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                                data = BakingStep.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                let newStep = BakingStep(data: data)
                                breadMethodData.steps = breadMethodData.steps.map { $0.id == updateId ? newStep : $0 }
                                isPresentingEditView = false
                                data = BakingStep.Data()
                                updateId = nil
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


struct BakingMethodEditDetailView_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @State var breadMethod = BreadRecipeMethod().data
        var body: some View {
            BakingMethodEditDetailView(breadMethodData: $breadMethod)
        }
    }
    static var previews: some View {
        NavigationStack{
            BindingTestHolder()
        }
    }
}
