//
//  EditStepView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/6/22.
//

import SwiftUI

struct EditStepView: View {
    @Binding var step: BakingStep.Data
    @FocusState private var isFocused: Bool
    @State private var newText = ""
    
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

extension Binding where
    Value: MutableCollection,
    Value: RangeReplaceableCollection
{
    subscript(_ index: Value.Index,default defaultValue: Value.Element)
    -> Binding<Value.Element> {
        Binding<Value.Element> {
            guard index < self.wrappedValue.endIndex else {
                return defaultValue
            }
            return self.wrappedValue[index]
        } set: { newValue in
            // It is possible that the index we are updating
            // is beyond the end of our array so we first
            // need to append items to the array to ensure
            // we are within range.
            while index >= self.wrappedValue.endIndex {
                self.wrappedValue.append(defaultValue)
            }
            
            self.wrappedValue[index] = newValue
        }
    }
}


struct EditStepView_Previews: PreviewProvider {
    static var previews: some View {
        EditStepView(step: .constant(BakingStep.sampleData[0].data))
    }
}
