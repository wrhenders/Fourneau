//
//  BakingStepCard.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

struct BakingStepCard: View {
    let bakingStep: BakingStep
    let startTime: Date
    
    var body: some View {
            VStack {
                Text(bakingStep.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                HStack{
                    Image(systemName: "clock")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("Start: \(startTime.formatted(date: .omitted, time: .shortened))")
                }
                HStack{
                    Image(systemName: "clock")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("End: \(Date(timeInterval: bakingStep.lengthInMinutes * 60, since: startTime).formatted(date: .omitted, time: .shortened))")
                }
                Image(bakingStep.type.name)
                    .resizable()
                    .scaledToFit()
                Text(bakingStep.description)
                    .font(.title3)
                
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .shadow(radius: 8)
    }
}

struct BakingStepCard_Previews: PreviewProvider {
    static var previews: some View {
        BakingStepCard(bakingStep: BakingStep.sampleData[0], startTime: Date())
    }
}
