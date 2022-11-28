//
//  BakingStepList.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

struct BakingStepList: View {
    @State private var breadRecipe = BreadRecipeSteps(recipe: BreadRecipe.sampleRecipe)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                let starts = breadRecipe.getStarts()
                ForEach(breadRecipe.steps.indices, id: \.self) { index in
                    BakingStepCard(bakingStep: breadRecipe.steps[index], startTime: starts[index])
                }
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
