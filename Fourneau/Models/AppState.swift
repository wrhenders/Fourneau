//
//  AppState.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/16/22.
//

import SwiftUI

final class AppState: ObservableObject {
    @Published var rootViewId = UUID()
    @Published var tabSelection = 1
}
