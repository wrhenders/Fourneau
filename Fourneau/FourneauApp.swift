//
//  FourneauApp.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

@main
struct FourneauApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var localNotificationCenter = LocalNotificationManager()
    @StateObject private var store = BakingStore()
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
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
                    .environmentObject(localNotificationCenter)
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
            .id(appState.tabSelection)
            .tint(.darkOrange)
            .environmentObject(appState)
            .environmentObject(store)
            .task {
                do {
                    store.storeData = try await BakingStore.load()
                } catch {
                }
            }
        }
    }
}
