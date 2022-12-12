//
//  BakingSummaryView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/8/22.
//

import SwiftUI

struct BakingSummaryView: View {
    @ObservedObject var store: BakingStore
    
    @Environment(\.scenePhase) private var scenePhase
    @State private var startNow = BakeTime.now
    @State private var finishBread = Date()
    
    let saveAction: ()->Void
    
    enum BakeTime {
        case now, future
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("bread")
                .resizable()
                .scaledToFit()
            List {
                Section(header: Text("Recipe")) {
                    NavigationLink(destination: BreadRecipeListView(recipe: $store.storeData.chosenRecipe, recipeList: $store.storeData.recipeList)){
                        Text(store.storeData.chosenRecipe.title)
                    }
                }
                Section(header: Text("Method")) {
                    NavigationLink(destination: BakingMethodListView(chosenMethod: $store.storeData.chosenMethod, bakingMethodList: $store.storeData.methodList)) {
                        Text(store.storeData.chosenMethod.title)
                    }
                }
                Section(header: Text("Start Time")) {
                    Picker("Bake Time", selection: $startNow) {
                        Text("Now").tag(BakeTime.now)
                        Text("Future").tag(BakeTime.future)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    if startNow == .future {
                        DatePicker("Finish:", selection: $finishBread, in:Date.now...)
                            .onChange(of: finishBread, perform: { _ in store.futureRecipeTimer(finishTime: finishBread)
                            })
                    }
                }
                Section {
                    if let binding = Binding($store.activeRecipeTimer) {
                        NavigationLink(destination: {BakingStepListView(recipeTimer: binding)}) {
                            Text("Bake")
                                .font(.title2)
                                .foregroundColor(Color.blue)
                        }
                    }
                }
            }
        }
        .navigationTitle("Baking Summary")
        .onAppear(perform: {if startNow == .now {
            store.newRecipeTimer()
        }})
        .onDisappear(perform: {saveAction()})
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {saveAction()}
        }
    }
}

struct BakingSummaryView_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @StateObject var store = BakingStore()
        var body: some View {
            BakingSummaryView(store: store, saveAction: {})
        }
    }
    static var previews: some View {
        NavigationStack {
            BindingTestHolder()
        }
    }
}
