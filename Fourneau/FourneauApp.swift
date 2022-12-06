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
            NavigationView{
                BakingMethodView(breadMethod: $breadMethod)
            }
        }
    }
}
