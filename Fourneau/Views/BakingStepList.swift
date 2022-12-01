//
//  BakingStepList.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

struct BakingStepList: View {
    @State private var breadRecipe = BreadRecipeSteps(recipe: BreadRecipe.sampleRecipe)
    @State var currentIndex: Int = 0
    
    func nextStep(currentIndex index: Int) {
        if index + 1 < breadRecipe.steps.count {
            currentIndex = index + 1
        }
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Recipe Steps")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            let starts = breadRecipe.getStarts()
            SnapCarousel(index: $currentIndex, length: breadRecipe.steps.count) {
                    ForEach(breadRecipe.steps.indices, id: \.self) { index in
                        BakingStepCard(bakingStep: $breadRecipe.steps[index], startTime: starts[index]) {self.nextStep(currentIndex: index)}
                    }
                }
            HStack(spacing: 8) {
                ForEach(breadRecipe.steps.indices, id: \.self) { index in
                    Circle()
                        .fill(Color.black.opacity(currentIndex == index ? 1 : 0.1))
                        .frame(width: 8, height: 8)
                        .scaleEffect(currentIndex == index ? 1.4 : 1)
                        .animation(.spring(), value: currentIndex == index)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct BakingStepList_Previews: PreviewProvider {
    static var previews: some View {
        BakingStepList()
    }
}
