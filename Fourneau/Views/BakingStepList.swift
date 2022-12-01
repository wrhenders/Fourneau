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
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Recipe Steps")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            let starts = breadRecipe.getStarts()
            SnapCarousel(index: $currentIndex, items: breadRecipe.steps) {
                    ForEach(breadRecipe.steps.indices, id: \.self) { index in
                            BakingStepCard(bakingStep: $breadRecipe.steps[index], startTime: starts[index])
                    }
            }
            HStack(spacing: 10) {
                ForEach(breadRecipe.steps.indices, id: \.self) { index in
                    Circle()
                        .fill(Color.black.opacity(currentIndex == index ? 1 : 0.1))
                        .frame(width: 10, height: 10)
                        .scaleEffect(currentIndex == index ? 1.4 : 1)
                        .animation(.spring(), value: currentIndex == index)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
//        ScrollView(.horizontal) {
//            HStack(spacing: 20) {

//            }
//            .padding(16)
//        }
    }
}

struct BakingStepList_Previews: PreviewProvider {
    static var previews: some View {
        BakingStepList()
    }
}
