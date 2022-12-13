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
    
    @State private var tabSelection = 1
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $tabSelection) {
                NavigationView{
                    BakingSummaryView(store: store, tabSelection: $tabSelection) {
                        Task {
                            do {
                                try await BakingStore.save(store: store.storeData)
                            } catch {}
                        }
                    }
                }
                .environmentObject(localNotificationCenter)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Bread Recipes")
                }
                .tag(1)
                NavigationView{
                    if let binding = Binding($store.activeRecipeTimer) {
                        BakingStepListView(recipeTimer: binding)
                    } else {
                        EmptyActiveRecipe(tabSelection: $tabSelection)
                    }
                    
                }.tabItem {
                    Image(systemName: "stove")
                    Text("Active Recipe")
                }.tag(2)
                NavigationView{
                }
                .tabItem {
                    Image(systemName: "mountain.2")
                    Text("Recipe Calculator")
                }
            }
            .task {
                do {
                    store.storeData = try await BakingStore.load()
                } catch {
                }
            }
        }
    }
}
