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
    
    @State var showingSteps = false
    
    var body: some View {
        NavigationView {
            if showingSteps {
                if let binding = Binding($store.storeData.activeRecipeTimer) {
                    BakingStepListView(recipeTimer: binding, showingSteps: $showingSteps)
                }
            } else {
                VStack{
                    Text("No Active Recipe...")
                    Button("Choose Recipe") {
                        appState.tabSelection = Tab.summary
                    }.buttonStyle(.borderedProminent)
                }
            }
        }.onAppear {
            showingSteps = store.storeData.activeRecipeTimer != nil
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
