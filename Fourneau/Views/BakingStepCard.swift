//
//  BakingStepCard.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

struct BakingStepCard: View {
    let bakingStep: BakingStep
    
    var body: some View {
            VStack {
                Text(bakingStep.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                HStack{
                    Image(systemName: "clock")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("Start: \(bakingStep.startingTime.formatted(date: .omitted, time: .shortened))")
                }
                HStack{
                    Image(systemName: "clock")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("End: \(bakingStep.endingTime.formatted(date: .omitted, time: .shortened))")
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
        BakingStepCard(bakingStep: BakingStep.sampleData[0])
    }
}
