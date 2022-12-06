//
//  BakingStepList.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

struct BakingStepListView: View {
    @Binding var breadMethod: BreadRecipeMethod
    @State var visibleIndex: Int = 0
    
    func nextStep(currentIndex index: Int) {
        if index + 1 < breadMethod.steps.count {
            visibleIndex = index + 1
            breadMethod.nextStep()
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                TimeCard(text: "Start Time:", time: "\(breadMethod.startTime.formatted(date: .omitted, time: .shortened))", color: .green)
                TimeCard(text: "Next Action:", time: "\(breadMethod.nextAction.formatted(date: .omitted, time: .shortened))", color: .cyan)
            }
            
            SnapCarousel(index: $visibleIndex, length: breadMethod.steps.count) {
                    ForEach(breadMethod.steps.indices, id: \.self) { index in
                        BakingStepCard(bakingStep: $breadMethod.steps[index], completed: breadMethod.stepCompleted[index], current: index == breadMethod.currentStep, startTime: breadMethod.startArray[index]) {self.nextStep(currentIndex: index)}
                    }
                }
            
            TimeCard(text: "Out of the Oven:", time: "\(breadMethod.endTime.formatted(date: .omitted, time: .shortened))", color: .red)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            
            HStack(spacing: 8) {
                ForEach(breadMethod.steps.indices, id: \.self) { index in
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
        @State var breadMethod = BreadRecipeMethod(recipe: BreadRecipe.sampleRecipe)
        var body: some View {
            BakingStepListView(breadMethod: $breadMethod)
        }
    }
    static var previews: some View {
        NavigationView{
            BindingTestHolder()
        }
    }
}
