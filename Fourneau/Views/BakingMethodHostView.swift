//
//  BakingMethodHost.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/16/22.
//

import SwiftUI

struct BakingMethodHostView: View {
    @Binding var method: BreadRecipeMethod
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var store: BakingStore
    
    @State private var isPresentingEditVeiw = false
    @State private var data = BreadRecipeMethod.Data()
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Steps")){
                    ForEach(method.steps) { step in
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
                        Text(method.totalTime.minToString())
                    }
                }
                HStack{
                    Button("Choose") {
                        store.storeData.chosenMethod = method
                        appState.rootViewId = UUID()
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
        }
        .navigationTitle(method.title)
        .toolbar{
            Button("Edit") {
                isPresentingEditVeiw = true
                data = method.data
            }
        }
        .sheet(isPresented: $isPresentingEditVeiw) {
            NavigationView {
                BakingMethodEditDetailView(breadMethodData: $data)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditVeiw = false
                                data = BreadRecipeMethod.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                let newMethod = BreadRecipeMethod(data: data)
                                method = newMethod
                                isPresentingEditVeiw = false
                                data = BreadRecipeMethod.Data()
                            }
                        }
                    }
            }
        }
    }
}

struct BakingMethodHost_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @State var breadMethod = BreadRecipeMethod()
        @StateObject var store = BakingStore()
        @StateObject var appState = AppState()
        
        var body: some View {
            BakingMethodHostView(method: $breadMethod)
                .environmentObject(store)
                .environmentObject(appState)
        }
    }
    static var previews: some View {
        NavigationStack {
            BindingTestHolder()
        }
    }
}
