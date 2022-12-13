//
//  EmptyActiveRecipe.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/13/22.
//

import SwiftUI

struct EmptyActiveRecipe: View {
    @Binding var tabSelection: Int
    var body: some View {
        VStack{
            Text("No Recipe Yet...")
            Button("Choose Recipe") {
                self.tabSelection = 1
            }
        }
    }
}

struct EmptyActiveRecipe_Previews: PreviewProvider {
    static var previews: some View {
        EmptyActiveRecipe(tabSelection: .constant(1))
    }
}
