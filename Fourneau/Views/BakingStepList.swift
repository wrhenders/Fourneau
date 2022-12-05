//
//  BakingStepList.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

struct BakingStepList: View {
    @State private var breadRecipe = BreadRecipeMethod(recipe: BreadRecipe.sampleRecipe)
    @State var visibleIndex: Int = 0
    
    func nextStep(currentIndex index: Int) {
        if index + 1 < breadRecipe.steps.count {
            visibleIndex = index + 1
            breadRecipe.nextStep()
        }
    }
    
    var body: some View {
        VStack {
            Text("Recipe Steps")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            TimeCard(text: "Start Time:", time: "\(breadRecipe.startTime.formatted(date: .omitted, time: .shortened))", color: .green)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            
            TimeCard(text: "Next Action:", time: "\(breadRecipe.nextAction.formatted(date: .omitted, time: .shortened))", color: .cyan)

            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            
            SnapCarousel(index: $visibleIndex, length: breadRecipe.steps.count) {
                    ForEach(breadRecipe.steps.indices, id: \.self) { index in
                        BakingStepCard(bakingStep: $breadRecipe.steps[index], completed: breadRecipe.stepCompleted[index], current: index == breadRecipe.currentStep, startTime: breadRecipe.startArray[index]) {self.nextStep(currentIndex: index)}
                    }
                }
            
            TimeCard(text: "Out of the Oven:", time: "\(breadRecipe.endTime.formatted(date: .omitted, time: .shortened))", color: .red)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            
            HStack(spacing: 8) {
                ForEach(breadRecipe.steps.indices, id: \.self) { index in
                    Circle()
                        .fill(Color.black.opacity(visibleIndex == index ? 1 : 0.1))
                        .frame(width: 8, height: 8)
                        .scaleEffect(visibleIndex == index ? 1.4 : 1)
                        .animation(.spring(), value: visibleIndex == index)
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
