//
//  BakingStepCard.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

struct BakingStepCard: View {
    @Binding var bakingStep: BakingStep
    let startTime: Date
    
    func markNextCompleted() {
        for i in 0..<bakingStep.methodCompleted.count {
            if bakingStep.methodCompleted[i] == false {
                bakingStep.methodCompleted[i].toggle()
                return
            }
        }
    }
    
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
                Divider()
                ForEach(bakingStep.description.indices, id: \.self) { index in
                    Text("\u{2022} " + bakingStep.description[index])
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .strikethrough(bakingStep.methodCompleted[index])
                    Divider()
                }
                HStack{
                    Button(action: {
                        self.markNextCompleted()
                    }) {Text("Mark Next")}
                }
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .shadow(radius: 8)
    }
}

struct BakingStepCard_Previews: PreviewProvider {
    static var previews: some View {
        BakingStepCard(bakingStep: .constant(BakingStep.sampleData[0]), startTime: Date())
    }
}
