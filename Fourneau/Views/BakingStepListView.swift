//
//  BakingStepList.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

struct BakingStepListView: View {
    @State var completedRecipe: CompletedRecipe
    @State var visibleIndex: Int = 0
    
    func nextStep(currentIndex index: Int) {
        if index + 1 < completedRecipe.steps.count {
            visibleIndex = index + 1
            completedRecipe.nextStep()
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                TimeCard(text: "Start Time:", time: "\(completedRecipe.startTime.formatted(date: .omitted, time: .shortened))", color: .green)
                TimeCard(text: "Next Action:", time: "\(completedRecipe.nextAction?.formatted(date: .omitted, time: .shortened) ?? "TBD")", color: .cyan)
            }
            
            SnapCarousel(index: $visibleIndex, length: completedRecipe.steps.count) {
                    ForEach(completedRecipe.steps.indices, id: \.self) { index in
                        BakingStepCard(bakingStep: $completedRecipe.steps[index], completed: completedRecipe.stepCompleted[index], current: index == completedRecipe.currentStep, startTime: completedRecipe.startArray[index]) {self.nextStep(currentIndex: index)}
                    }
                }
            
            TimeCard(text: "Out of the Oven:", time: "\(completedRecipe.endTime.formatted(date: .omitted, time: .shortened))", color: .red)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            
            HStack(spacing: 8) {
                ForEach(completedRecipe.steps.indices, id: \.self) { index in
                    Circle()
                        .fill(Color.black.opacity(visibleIndex == index ? 1 : 0.1))
                        .frame(width: 8, height: 8)
                        .scaleEffect(visibleIndex == index ? 1.4 : 1)
                        .animation(.spring(), value: visibleIndex == index)
                }
            }
        }
        .navigationTitle("Recipe Steps")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BakingStepList_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @State var completeMethod = CompletedRecipe(title: "Standard", steps: BreadRecipeMethod().steps, recipe: BreadRecipe.sampleRecipe)

        var body: some View {
            BakingStepListView(completedRecipe: completeMethod)
        }
    }
    static var previews: some View {
        NavigationView{
            BindingTestHolder()
        }
    }
}
