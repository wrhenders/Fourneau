//
//  FourneauApp.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

@main
struct FourneauApp: App {
    @StateObject private var store = BakingStore()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView{
                    BakingSummaryView(store: store)
                }
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Bread Recipes")
                }
                NavigationView{
                }
                .tabItem {
                    Image(systemName: "mountain.2")
                    Text("Recipe Calculator")
                }
            }
        }
    }
}
