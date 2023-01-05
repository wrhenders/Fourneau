//
//  MethodRow.swift
//  Fourneau
//
//  Created by Ryan Henderson on 1/5/23.
//

import SwiftUI

struct MethodRow: View {
    let method: BreadRecipeMethod
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(method.title).bold()
                    .font(.title3)
                HStack {
                    Text("Total Time:").bold()
                    Text(method.totalTime.minToString())
                }
            }
            Spacer()
            if method.locked {
                Image(systemName: "lock.fill")
            }
        }
    }
}

struct MethodRow_Previews: PreviewProvider {
    static var previews: some View {
        MethodRow(method: BreadRecipeMethod())
    }
}
