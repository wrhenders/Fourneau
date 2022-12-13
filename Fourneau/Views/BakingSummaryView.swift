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
    @State private var startNow: BakeTime?
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
                        Text("Now").tag(BakeTime.now as BakeTime?)
                        Text("Future").tag(BakeTime.future as BakeTime?)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: startNow, perform: {value in
                        if value == .now {
                            store.newRecipeTimer()
                        }
                    })
                    
                    if startNow == .future {
                        DatePicker("Finish:", selection: $finishBread, in:Date.now...)
                            .onChange(of: finishBread, perform: { value in store.futureRecipeTimer(finishTime: finishBread)
                            })
                    }
                }
                if startNow != nil {
                    ZStack {
                        Button(action: {
                            startNow == .future ? store.futureRecipeTimer(finishTime: finishBread) :
                            store.newRecipeTimer()
                        }) {
                            Text("Bake")
                                .font(.title2)
                                .foregroundColor(Color.blue)
                        }
                        if let binding = Binding($store.activeRecipeTimer) {
                            NavigationLink(destination: BakingStepListView(recipeTimer: binding)) { EmptyView()}
                        }
                    }
                }
            
            }
        }
        .navigationTitle("Baking Summary")
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
