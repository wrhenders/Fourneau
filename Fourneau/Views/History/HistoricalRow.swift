//
//  HistoricalRow.swift
//  Fourneau
//
//  Created by Ryan Henderson on 1/4/23.
//

import SwiftUI

struct HistoricalRow: View {
    let history: HistoricalBake
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(history.method.title).bold()
                    .font(.title3)
                Spacer()
                Text(history.dateCompleted.formatted(date: .abbreviated, time: .omitted))
            }
            HStack {
                Text("Total Time:").bold()
                Text(history.totalMinutes.minToString())
            }
            HStack {
                Text("Recipe:").bold()
                Text(history.recipe.title)
            }
        }
    }
}

struct HistoricalRow_Previews: PreviewProvider {
    static var previews: some View {
        HistoricalRow(history: HistoricalBake.sampleHistory)
    }
}
