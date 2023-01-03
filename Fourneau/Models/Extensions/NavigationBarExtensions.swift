//
//  NavigationBarExtensions.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/16/22.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
  var backgroundColor: UIColor
  var textColor: UIColor

  init(backgroundColor: UIColor, textColor: UIColor) {
    self.backgroundColor = backgroundColor
    self.textColor = textColor
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithTransparentBackground()
    coloredAppearance.backgroundColor = .clear
    coloredAppearance.titleTextAttributes = [.foregroundColor: textColor]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: textColor]

    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    UINavigationBar.appearance().tintColor = textColor
    UINavigationBar.appearance().isOpaque = true
  }

  func body(content: Content) -> some View {
    ZStack{
       content
        VStack {
          GeometryReader { geometry in
              Color.darkGray
                 .frame(height: geometry.safeAreaInsets.top)
                 .edgesIgnoringSafeArea(.top)
              Color(self.backgroundColor)
                  .frame(height: geometry.safeAreaInsets.top - 90 > 10 ? geometry.safeAreaInsets.top - 90 : 0)
                 .edgesIgnoringSafeArea(.top)
              Spacer()
          }
        }
     }
  }
}

extension View {
    /// Sets the text color for a navigation bar title.
    /// - Parameter color: Color the title should be
    ///
    /// Supports both regular and large titles.
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        let navBarAppearance = UINavigationBar.appearance()
        // Set appearance for both normal and large sizes.
        navBarAppearance.titleTextAttributes = [.foregroundColor: uiColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: uiColor]
        return self
    }
    
    func navigationBarColor(_ backgroundColor: UIColor, textColor: UIColor) -> some View {
      self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, textColor: textColor))
    }
    
    var defaultNavigation: some View {
        self.navigationBarColor(UIColor(Color.darkOrange), textColor: UIColor(Color.title))
    }
}
