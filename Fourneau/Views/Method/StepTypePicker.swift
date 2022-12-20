//
//  StepTypePicker.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/6/22.
//

import SwiftUI

struct StepTypePicker: View {
    @Binding var type: BakingStepType
    
    var body: some View {
        Picker("", selection: $type) {
            ForEach(BakingStepType.pickerChoices) {type in
                Text(type.title)
                    .tag(type)
            }
        }.pickerStyle(.menu)
    }
}

struct StepTypePicker_Previews: PreviewProvider {
    static var previews: some View {
        StepTypePicker(type: .constant(.bake))
    }
}
