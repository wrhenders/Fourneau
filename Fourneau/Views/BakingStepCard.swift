//
//  BakingStepCard.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

struct BakingStepCard: View {
    @Binding var bakingStep: BakingStep
    let completed: Bool
    let current: Bool
    let startTime: Date
    let nextAction: () -> Void
    
    func getShadowColor() -> Color {
        if current {
            return Color.red
        } else if completed {
            return Color.green
        } else {
            return Color.black
        }
    }
    
    var body: some View {
        VStack(spacing:8) {
                Text(bakingStep.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                Divider()
                Label("Started: \(startTime.formatted(date: .omitted, time: .shortened))", systemImage: "clock")
                
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack{

                }
                Image(bakingStep.type.name)
                    .resizable()
                    .scaledToFit()
                Divider()
                ForEach(bakingStep.description.indices, id: \.self) { index in
                    Text("\u{2022} " + bakingStep.description[index])
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .strikethrough(bakingStep.methodCompleted[index])
                        .onTapGesture {
                            bakingStep.methodCompleted[index].toggle()
                        }
                    Divider()
                }
                HStack{
                    Label("End: \(Date(timeInterval: bakingStep.lengthInMinutes * 60, since: startTime).formatted(date: .omitted, time: .shortened))", systemImage: "clock")
                    Button(action: {
                        nextAction()
                    }) {
                        Text("Next")
                        Image(systemName: "chevron.right")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .disabled(!current)
                }
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .shadow(color: getShadowColor(), radius: 8)
        
    }
}

struct BakingStepCard_Previews: PreviewProvider {
    static var previews: some View {
        BakingStepCard(bakingStep: .constant(BakingStep.sampleData[0]),completed: false, current: true, startTime: Date(), nextAction: {})
    }
}
