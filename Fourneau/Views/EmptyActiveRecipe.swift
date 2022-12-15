//
//  EmptyActiveRecipe.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/13/22.
//

import SwiftUI

struct EmptyActiveRecipe: View {
    @ObservedObject var store: BakingStore
    @Binding var tabSelection: Int
    
    var body: some View {
        if let binding = Binding($store.storeData.activeRecipeTimer) {
            BakingStepListView(recipeTimer: binding, store: store, tabSelection: $tabSelection)
        } else {
            VStack{
                Text("No Active Recipe...")
                Button("Choose Recipe") {
                    self.tabSelection = 1
                }.buttonStyle(.borderedProminent)
            }
        }
    }
}

struct EmptyActiveRecipe_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @StateObject var store = BakingStore()
        
        var body: some View {
            EmptyActiveRecipe(store: store, tabSelection: .constant(1))
        }
    }
    static var previews: some View {
        NavigationView{
            BindingTestHolder()
                .environmentObject(LocalNotificationManager())
        }
    }
}
