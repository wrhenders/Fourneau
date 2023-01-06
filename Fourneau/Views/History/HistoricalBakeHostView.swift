//
//  HistoricalBakeHostView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 1/4/23.
//

import SwiftUI

struct HistoricalBakeHostView: View {
    let history: HistoricalBake
    
    @EnvironmentObject var store: BakingStore
    @EnvironmentObject var appState: AppState

    @State private var isPresentingDetailView = false
    @State private var data = BreadRecipeMethod.Data()
    
    @Environment(\.dismiss) var dismiss
    
    func done() {
        dismiss()
    }
    
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Recipe")){
                    Text(history.recipe.title).bold()
                        .frame(maxWidth: .infinity)
                    HStack{
                        Text("Temp: \(history.recipe.bakeTempF) F").bold()
                        Spacer()
                        Text("Time: \(Int(history.recipe.bakeTimeInMinutes)) Min").bold()
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Ingredients:").bold()
                        ForEach(history.recipe.ingredients, id: \.self) {line in
                            Text(line)
                        }
                    }
                    
                }
                Section(header: Text("Steps")){
                    ForEach(history.method.steps) { step in
                        HStack{
                            Text(step.title)
                            Spacer()
                            Text("\(step.lengthInMinutes.minToString())")
                        }
                    }
                }
                Section {
                    HStack{
                        Spacer()
                        Text("Total Time:").bold()
                        Text(history.method.totalTime.minToString())
                    }
                }
                Button("Save Method") {
                    data = BreadRecipeMethod(title: history.method.title, steps: history.method.steps).data
                    isPresentingDetailView = true
                }
                .font(.title2)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity)
                .buttonStyle(.plain)
                .listRowBackground(Color.darkOrange)
                
            }
        }
        .navigationTitle("Bake on \(history.dateCompleted.formatted(date: .abbreviated, time: .omitted))")
        .defaultNavigation
        .sheet(isPresented: $isPresentingDetailView) {
            NavigationView {
                BakingMethodEditDetailView(breadMethodData: $data)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingDetailView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                let newMethod = BreadRecipeMethod(data: data)
                                store.storeData.methodList.append(newMethod)
                                isPresentingDetailView = false
                                appState.tabSelection = Tab.summary
                                done()
                            }
                        }
                    }
            }
        }
    }
}

struct HistoricalBakeHostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HistoricalBakeHostView(history: HistoricalBake.sampleHistory)
        }
    }
}
