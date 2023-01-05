//
//  TabView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 1/5/23.
//

import SwiftUI

struct TabViewHost: View {
    @EnvironmentObject var store: BakingStore
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView(selection: $appState.tabSelection) {
            BakingSummaryView() {
                    Task {
                        do {
                            try await BakingStore.save(store: store.storeData)
                        } catch {}
                    }
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(Tab.summary)
        
            EmptyActiveRecipe()
                .tabItem {
                    Image(systemName: "stove")
                    Text("Active Bake")
                }.tag(Tab.active)
            
            HistoricalBakeList()
                .tabItem {
                    Image(systemName: "archivebox")
                    Text("History")
                }.tag(Tab.history)
            
            RecipeCalculatorView()
                .tabItem {
                    Image(systemName: "candybarphone")
                    Text("Recipe Calculator")
                }.tag(Tab.calculator)
            ShopView()
                .tabItem {
                    Image(systemName: "frying.pan")
                    Text("Shop")
                }.tag(Tab.shop)
        }
    }
}
