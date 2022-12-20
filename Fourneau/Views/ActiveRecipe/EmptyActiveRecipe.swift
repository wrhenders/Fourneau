//
//  EmptyActiveRecipe.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/13/22.
//

import SwiftUI

struct EmptyActiveRecipe: View {
    @EnvironmentObject var store: BakingStore
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        if let binding = Binding($store.storeData.activeRecipeTimer) {
            BakingStepListView(recipeTimer: binding)
        } else {
            VStack{
                Text("No Active Recipe...")
                Button("Choose Recipe") {
                    appState.tabSelection = 1
                }.buttonStyle(.borderedProminent)
            }
        }
    }
}

struct EmptyActiveRecipe_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @StateObject var store = BakingStore()
        @StateObject var appState = AppState()
        
        var body: some View {
            EmptyActiveRecipe()
                .environmentObject(store)
                .environmentObject(appState)
        }
    }
    static var previews: some View {
        NavigationView{
            BindingTestHolder()
        }
    }
}
