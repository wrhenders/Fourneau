//
//  BakingStepList.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

struct BakingStepListView: View {
    @Binding var recipeTimer: CompletedRecipeTimer
    
    @State var visibleIndex: Int = 0
    @EnvironmentObject var notificationManager: LocalNotificationManager
    
    func nextStep(currentIndex index: Int) {
        if index + 1 < recipeTimer.steps.count {
            visibleIndex = index + 1
            recipeTimer.nextStep()
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                TimeCard(text: "Start Time:", time: "\(recipeTimer.startTime.formatted(date: .omitted, time: .shortened))", color: .green)
                TimeCard(text: "Next Action:", time: "\(recipeTimer.nextAction?.formatted(date: .omitted, time: .shortened) ?? "TBD")", color: .cyan)
            }
            
            SnapCarousel(index: $visibleIndex, length: recipeTimer.steps.count) {
                    ForEach(recipeTimer.steps.indices, id: \.self) { index in
                        BakingStepCard(bakingStep: $recipeTimer.steps[index], completed: recipeTimer.stepCompleted[index], current: index == recipeTimer.currentStep, startTime: recipeTimer.startArray[index]) {self.nextStep(currentIndex: index)}
                    }
                }
            
            TimeCard(text: "Out of the Oven:", time: "\(recipeTimer.endTime.formatted(date: .omitted, time: .shortened))", color: .red)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            
            HStack(spacing: 8) {
                ForEach(recipeTimer.steps.indices, id: \.self) { index in
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
//        .onAppear {
//            self.notificationManager.sendNotification(title: "Test", body: "Body Test", launchIn: 3)
//        }
    }
}

struct BakingStepList_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @State var completeMethod = CompletedRecipeTimer(steps: BreadRecipeMethod().steps, recipe: BreadRecipe.sampleRecipe)

        var body: some View {
            BakingStepListView(recipeTimer: $completeMethod)
        }
    }
    static var previews: some View {
        NavigationView{
            BindingTestHolder()
        }
    }
}
