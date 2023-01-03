//
//  BakingStepCard.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

struct BakingStepCard: View {
    @Binding var bakingStep: BakingStep
    
    let cardState: CardState
    
    let startTime: Date
    let nextAction: () -> Void
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing){
                Image(bakingStep.type.name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(bakingStep.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.title)
                    .padding(16)
            }
            VStack(spacing: 8) {
                HStack {
                    Label("Started: \(startTime.formatted(date: .omitted, time: .shortened))", systemImage: "clock")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if bakingStep.temp != nil {
                        Label("Temp: \(bakingStep.temp!) F", systemImage: "thermometer.medium")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                Divider()
                Spacer()
                ForEach(bakingStep.description.indices, id: \.self) { index in
                    Text("\u{2022} " + bakingStep.description[index])
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .strikethrough(bakingStep.methodCompleted[index])
                        .onTapGesture {
                            bakingStep.methodCompleted[index].toggle()
                        }
                }
                Spacer()
                Divider()
                HStack{
                    Text("Length: \(bakingStep.lengthInMinutes.minToString())")
                    Button(action: {
                        nextAction()
                    }) {
                        cardState == .last || cardState == .lastActive ?
                        Text("Done") :
                        Text("Next")
                        Image(systemName: "chevron.right")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .disabled(cardState != .current && cardState != .lastActive)
                }
                .padding(.bottom)
            }
            .padding(.horizontal, 16)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: cardState.color, radius: 8)
    }
    
}

struct BakingStepCard_Previews: PreviewProvider {
    static var previews: some View {
        BakingStepCard(bakingStep: .constant(BreadRecipeMethod().steps[0]), cardState: .lastActive, startTime: Date(), nextAction: {})
    }
}
