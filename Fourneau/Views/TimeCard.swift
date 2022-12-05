//
//  TimeCard.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/5/22.
//

import SwiftUI

struct TimeCard: View {
    let text: String
    let time: String
    let color: Color
    
    var body: some View {
        HStack {
            Text(text)
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(width: 100, height: 40)
                .overlay {
                    Text(time)
                        .font(.title2)
                }
        }
    }
}

struct TimeCard_Previews: PreviewProvider {
    static var previews: some View {
        TimeCard(text: "Start Time:", time: "1:45 AM", color: Color.green)
    }
}
