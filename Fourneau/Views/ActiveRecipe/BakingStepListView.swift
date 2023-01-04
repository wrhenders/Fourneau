//
//  BakingStepList.swift
//  Fourneau
//
//  Created by Ryan Henderson on 11/28/22.
//

import SwiftUI

struct BakingStepListView: View {
    @Binding var recipeTimer: CompletedRecipeTimer
    @EnvironmentObject var store: BakingStore
    @EnvironmentObject var appState: AppState
    
    @State var visibleIndex: Int = 0
    
    @EnvironmentObject var notificationManager: LocalNotificationManager
    @Environment(\.dismiss) var dismiss
    
    func getCardState(currentIndex index: Int) -> CardState {
        if index == recipeTimer.steps.count - 1 {
            if index == recipeTimer.currentStep {
                return .lastActive
            }
            return .last
        }
        else if index == recipeTimer.currentStep {
            return .current
        }
        else if recipeTimer.stepCompleted[index] == true {
            return .completed
        }
        return .incomplete
    }
    
    func nextStep(currentIndex index: Int) {
        if index + 1 < recipeTimer.steps.count {
            visibleIndex = index + 1
            recipeTimer.nextStep()
            addNotification(fromStepIndex: visibleIndex)
        }
        if index + 1 == recipeTimer.steps.count {
            store.storeData.historicalBakeList.append(recipeTimer.makeHistoricalBake())
            done()
        }
    }
    
    func done() {
        notificationManager.removeNotifications()
        appState.tabSelection = Tab.summary
        recipeTimer.recipeCompleted = true
        dismiss()
    }
    
    func addNotification(fromStepIndex index: Int) {
        if recipeTimer.steps.indices.contains(index + 1) {
            if recipeTimer.steps[index].lengthInMinutes > 0 {
                notificationManager.sendNotification(title: "Bread Action Time!", body: "Next Step: \(recipeTimer.steps[index + 1].title)", launchIn: Double(recipeTimer.steps[index].lengthInMinutes) * 60)
            } else {
                notificationManager.sendNotification(title: "Bread Action Time!", body: "Next Step: \(recipeTimer.steps[index + 1].title)", launchIn: 1)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TimeCard(text: "Next Action:", time: "\(recipeTimer.nextAction?.formatted(date: .omitted, time: .shortened) ?? "TBD")", color: .cyan)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                SnapCarousel(index: $visibleIndex, length: recipeTimer.steps.count) {
                    ForEach(recipeTimer.steps.indices, id: \.self) { index in
                        BakingStepCard(bakingStep: $recipeTimer.steps[index], cardState: getCardState(currentIndex: index), startTime: recipeTimer.startArray[index]) {self.nextStep(currentIndex: index)}
                    }
                }
                
                TimeCard(text: "Out of the Oven:", time: "\(recipeTimer.endTime.formatted(date: .omitted, time: .shortened))", color: .red)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
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
            .onAppear {
                visibleIndex = recipeTimer.currentStep
                if notificationManager.notifications.isEmpty && recipeTimer.currentStep == 0 {
                    addNotification(fromStepIndex: visibleIndex)
                }
            }
            .onDisappear {
                if store.storeData.activeRecipeTimer != nil {
                    if store.storeData.activeRecipeTimer?.recipeCompleted == true {
                        store.storeData.activeRecipeTimer = nil
                    }
                }
            }
            .navigationTitle("Recipe Steps")
            .navigationBarTitleDisplayMode(.inline)
            .defaultNavigation
        }
    }
}

struct BakingStepList_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @State var completeMethod = CompletedRecipeTimer(title: "Standard", steps: BreadRecipeMethod().steps, recipe: BreadRecipe.sampleRecipe)

        var body: some View {
            BakingStepListView(recipeTimer: $completeMethod)
        }
    }
    static var previews: some View {
        BindingTestHolder()
            .environmentObject(LocalNotificationManager())
    }
}
