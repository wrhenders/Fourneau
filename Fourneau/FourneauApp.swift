//
//  FourneauApp.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

@main
struct FourneauApp: App {
    @State var breadMethod = BreadRecipeMethod(recipe: BreadRecipe.sampleRecipe)
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView{
                    BakingMethodView(breadMethod: $breadMethod)
                }
                .tabItem {
                    Image(systemName: "list.clipboard")
                    Text("Baking Method")
                }
                NavigationView{
                    BreadRecipeListView()
                }
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Bread Recipes")
                }
            }
        }
    }
}
