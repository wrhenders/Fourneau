//
//  BakingStepList.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

struct BakingStepList: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                BakingStepCard(bakingStep: BakingStep.sampleData[0])
                BakingStepCard(bakingStep: BakingStep.sampleData[1])
                BakingStepCard(bakingStep: BakingStep.sampleData[2])
            }
            .padding(16)
        }
    }
}

struct BakingStepList_Previews: PreviewProvider {
    static var previews: some View {
        BakingStepList()
    }
}
