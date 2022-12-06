//
//  EditStepView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/6/22.
//

import SwiftUI

struct EditStepView: View {
    @Binding var step: BakingStep
    
    var body: some View {
        VStack (spacing: 8) {
            TextField("Step Title", text: $step.title)
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            HStack {
                Text("Minutes:")
                TextField("Min", value: $step.lengthInMinutes, format:.number)
                    .keyboardType(.numberPad)
            }
            Divider()
            HStack {
                Text("Step Type:")
                Spacer()
                StepTypePicker(type: $step.type)
            }
            Divider()
            Text("Description:")
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach($step.description, id: \.self) {$line in
                HStack{
                    Text("\u{2022}")
                    TextField("Description", text: $line, axis: .vertical)
                }
            }.onDelete {indicies in
                step.description.remove(atOffsets: indicies)
            }
            Button(action: {step.description.append(" ")}) {
                Label("Add Description line", systemImage: "plus.circle.fill")
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 2)
    }
}

struct EditStepView_Previews: PreviewProvider {
    static var previews: some View {
        EditStepView(step: .constant(BakingStep.sampleData[0]))
    }
}
