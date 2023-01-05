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
            TabViewHost()
                .tint(.darkOrange)
                .environmentObject(appState)
                .environmentObject(store)
                .environmentObject(localNotificationCenter)
                .task {
                    do {
                        store.storeData = try await BakingStore.load()
                    } catch {
                    }
                }
        }
    }
}
