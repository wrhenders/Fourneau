//
//  BakingStepList.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

struct BakingStepList: View {
    @State private var breadRecipe = BreadRecipeSteps(recipe: BreadRecipe.sampleRecipe)
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
            HStack {
                Text("Start Time:")
                RoundedRectangle(cornerRadius: 8)
                    .fill(.green)
                    .frame(width: 120, height: 40)
                    .overlay {
                        Text("\(breadRecipe.startTime.formatted(date: .omitted, time: .shortened))")
                            .font(.title2)
                    }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            
            HStack {
                Text("Next Action:")
                RoundedRectangle(cornerRadius: 8)
                    .fill(.cyan)
                    .frame(width: 120, height: 40)
                    .overlay {
                        Text("\(breadRecipe.nextAction.formatted(date: .omitted, time: .shortened))")
                            .font(.title2)
                    }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            
            SnapCarousel(index: $visibleIndex, length: breadRecipe.steps.count) {
                    ForEach(breadRecipe.steps.indices, id: \.self) { index in
                        BakingStepCard(bakingStep: $breadRecipe.steps[index], completed: breadRecipe.stepCompleted[index], current: index == breadRecipe.currentStep, startTime: breadRecipe.startArray[index]) {self.nextStep(currentIndex: index)}
                    }
                }
            
//            if timer?.startDate == nil {
//                Button(action: {self.startRecipe()}) {
//                    Text("Begin!")
//                        .font(.title)
//                }
//            }
            
            HStack {
                Text("End:")
                RoundedRectangle(cornerRadius: 8)
                    .fill(.red)
                    .frame(width: 120, height: 40)
                    .overlay {
                        Text("\(breadRecipe.endTime.formatted(date: .omitted, time: .shortened))")
                            .font(.title2)
                    }
            }
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
