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
    
    func timeDisplay(_ length: Int ) -> String {
        let minutes = length % 60
        switch length {
        case 0...1: return "\(length) Minute"
        case 2...59: return "\(length) Minutes"
        case 60...119: return minutes > 0 ? "\(length / 60) Hour \(minutes) Minutes" : "\(length / 60) Hour"
        case 120...: return minutes > 0 ? "\(length / 60) Hours \(minutes) Minutes" : "\(length / 60) Hours"
        default: return ""
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
            Spacer()
            Image(bakingStep.type.name)
                .resizable()
                .scaledToFit()
            Spacer()
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
            Spacer()
            HStack{
                Text("Length: \(timeDisplay(bakingStep.lengthInMinutes))")
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
