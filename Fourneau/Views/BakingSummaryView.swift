//
//  BakingSummaryView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/8/22.
//

import SwiftUI

struct BakingSummaryView: View {
    @EnvironmentObject var store: BakingStore
    @EnvironmentObject var appState: AppState
    
    @Environment(\.scenePhase) private var scenePhase
    @State private var startNow: BakeTime?
    @State private var finishBread = Date()
    
    let saveAction: ()->Void
    
    enum BakeTime {
        case now, future
    }
    
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack(alignment: .center, spacing: 0) {
                    Image("bread")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: 350)
                    List {
                        Section(header: Text("Recipe Ingredients")) {
                            NavigationLink(destination: BreadRecipeListView(recipe: $store.storeData.chosenRecipe, recipeList: $store.storeData.recipeList)){
                                RecipeRow(recipe: store.storeData.chosenRecipe)
                            }
                        }
                        Section(header: Text("Method")) {
                            NavigationLink(destination: BakingMethodListView(chosenMethod: $store.storeData.chosenMethod, bakingMethodList: $store.storeData.methodList)) {
                                MethodRow(method: store.storeData.chosenMethod)
                            }
                        }
                        Section(header: Text("Start Time")) {
                            Picker("Bake Time", selection: $startNow) {
                                Text("Now").tag(BakeTime.now as BakeTime?)
                                Text("Future").tag(BakeTime.future as BakeTime?)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                            if startNow == .future {
                                DatePicker("Finish:", selection: $finishBread, in:Date.now...)
                            }
                        }
                        if startNow != nil {
                            Button("Bake") {
                                startNow == .future ? store.futureRecipeTimer(finishTime: finishBread) :
                                store.newRecipeTimer()
                                appState.tabSelection = Tab.active
                            }
                            .font(.title2)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .buttonStyle(.plain)
                            .listRowBackground(Color.darkOrange)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
                .edgesIgnoringSafeArea(.top)
            }
            .id(appState.rootViewId)
            .navigationTitle("Baking Summary")
            .onDisappear{
                startNow = nil
                saveAction()
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive {saveAction()}
            }
        }
    }
}

struct BakingSummaryView_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @StateObject var store = BakingStore()
        @StateObject var appState = AppState()
        
        var body: some View {
            BakingSummaryView(saveAction: {})
                .environmentObject(store)
                .environmentObject(appState)
        }
    }
    static var previews: some View {
            BindingTestHolder()
    }
}


