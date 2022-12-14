//
//  EditStepView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/6/22.
//

import SwiftUI

struct EditStepView: View {
    @Binding var step: BakingStep.Data
    
    var body: some View {
        Form {
            Section(header: Text("Step Data")){
                TextField("Step Title", text: $step.title)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text("Minutes:")
                    TextField("Min", value: $step.lengthInMinutes, format:.number)
                }
                HStack {
                    Text("Temp?:")
                    TextField("Temp", value: $step.temp, format:.number)
                }
                HStack {
                    Text("Step Type:")
                    Spacer()
                    StepTypePicker(type: $step.type)
                }
            }
            Section(header: Text("Description")) {
                ForEach(0..<step.description.count, id: \.self) { index in
                    HStack{
                        Text("\u{2022}")
                        TextField("Description", text: $step.description[index, default: ""])
                    }
                }
                .onDelete { indicies in
                    step.description.remove(atOffsets: indicies)
                }
                Button(action: {
                    step.description.append("")
                }) {
                    Label("Add Description line", systemImage: "plus.circle.fill")
                }
            }
        }
    }
}


struct EditStepView_Previews: PreviewProvider {
    static var previews: some View {
        EditStepView(step: .constant(BakingStep.sampleData[0].data))
    }
}
