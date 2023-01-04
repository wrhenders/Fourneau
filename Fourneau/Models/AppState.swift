//
//  AppState.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/16/22.
//

import SwiftUI

enum Tab {
    case summary
    case active
    case history
    case calculator
    case shop
}

final class AppState: ObservableObject {
    @Published var rootViewId = UUID()
    @Published var tabSelection = Tab.summary
}
