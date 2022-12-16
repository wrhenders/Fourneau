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
                NavigationView{
                    BakingSummaryView() {
                        Task {
                            do {
                                try await BakingStore.save(store: store.storeData)
                            } catch {}
                        }
                    }
                    .id(appState.rootViewId)
                }
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Bread Recipes")
                }
                .tag(1)
                
                NavigationView{
                    EmptyActiveRecipe()
                }
                .environmentObject(localNotificationCenter)
                .tabItem {
                    Image(systemName: "stove")
                    Text("Active Recipe")
                }.tag(2)
                
                NavigationView{
                }
                .tabItem {
                    Image(systemName: "mountain.2")
                    Text("Recipe Calculator")
                }.tag(3)
                
                NavigationView{
                    Link("Shop Forneau", destination: URL(string:"https://www.fourneauoven.com/")!)
                        .font(.title)
                }.tabItem {
                    Image(systemName: "frying.pan")
                    Text("Shop")
                }.tag(4)
            }
            .environmentObject(appState)
            .environmentObject(store)
            .id(appState.tabSelection)
            .onChange(of: appState.tabSelection) { _ in
                if store.storeData.activeRecipeTimer != nil {
                    if store.storeData.activeRecipeTimer?.recipeCompleted == true {
                        store.storeData.activeRecipeTimer = nil
                    }
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
