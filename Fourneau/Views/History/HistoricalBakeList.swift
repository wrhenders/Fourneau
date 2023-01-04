//
//  HistoricalBakeList.swift
//  Fourneau
//
//  Created by Ryan Henderson on 1/4/23.
//

import SwiftUI

struct HistoricalBakeList: View {
    @EnvironmentObject var store: BakingStore
    
    @State private var showingAlert = false
    
    var body: some View {
        List {
            Section{
                ForEach($store.storeData.historicalBakeList) { $history in
                    ZStack(alignment: .leading) {
                        NavigationLink(destination: EmptyView()) {
                            HistoricalRow(history: history)
                        }
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationTitle("Bake History")
        .defaultNavigation
        .toolbar{
            Button("Clear") {
                showingAlert = true
            }
        }
        .alert(isPresented: $showingAlert){
            Alert(
                title: Text("Would you like to clear your history?"),
                message: Text("Cleared history cannot be recovered"),
                primaryButton: .destructive(Text("No Thanks")) {
                    showingAlert = false
                },
                secondaryButton: .default(Text("Clear")) {
                    store.storeData.historicalBakeList = []
                    showingAlert = false
                }
            )
        }
    }
}

struct HistoricalBakeList_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @StateObject var store = BakingStore()
        
        var body: some View {
            HistoricalBakeList()
                .environmentObject(store)
                .onAppear {
                    store.storeData.historicalBakeList.append(HistoricalBake.sampleHistory)
                }
        }
    }
    static var previews: some View {
        NavigationStack {
            BindingTestHolder()
        }
    }
}
