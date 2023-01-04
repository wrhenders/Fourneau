//
//  AppState.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/16/22.
//

import SwiftUI

enum Tab: Hashable {
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

final class Router<T:Hashable>: ObservableObject {
    @Published var paths: [T] = []
    
    func push (_ path: T) {
        paths.append(path)
    }
    func pop() {
        paths.removeLast(1)
    }
    func popToRoot() {
        paths.removeAll()
    }
}
