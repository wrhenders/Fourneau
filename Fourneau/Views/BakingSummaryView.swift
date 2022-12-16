//
//  BakingSummaryView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/8/22.
//

import SwiftUI

struct BakingSummaryView: View {
    @ObservedObject var store: BakingStore
    @Binding var tabSelection: Int
    
    @Environment(\.scenePhase) private var scenePhase
    @State private var startNow: BakeTime?
    @State private var finishBread = Date()
    
    let saveAction: ()->Void
    
    enum BakeTime {
        case now, future
    }
    
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center, spacing: 0) {
            Image("bread")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: proxy.size.width, height: 350)
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
                    
                    if startNow == .future {
                        DatePicker("Finish:", selection: $finishBread, in:Date.now...)
                    }
                }
                if startNow != nil {
                    Button(action: {
                        startNow == .future ? store.futureRecipeTimer(finishTime: finishBread) :
                        store.newRecipeTimer()
                        self.tabSelection = 2
                    }) {
                        Text("Bake")
                            .font(.title2)
                            .foregroundColor(Color.blue)
                    }
                }
            }
            }
            .edgesIgnoringSafeArea(.top)
        }
        .navigationTitle("Baking Summary")
        .navigationBarTitleTextColor(Color("Title"))
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
            BakingSummaryView(store: store, tabSelection: .constant(1), saveAction: {})
        }
    }
    static var previews: some View {
        NavigationStack {
            BindingTestHolder()
        }
    }
}


