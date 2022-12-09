//
//  BakingMethodListView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/8/22.
//

import SwiftUI

struct BakingMethodListView: View {
    @Binding var chosenMethod: BreadRecipeMethod
    @Binding var bakingMethodList: [BreadRecipeMethod]
    
    @State var isPresentingDetailView = false
    @State var data = BreadRecipeMethod.Data()
    @State private var updateIndex = 0
    
    var body: some View {
        
        List {
            ForEach(Array(bakingMethodList.enumerated()), id:\.element) {index, methodRow in
                HStack{
                    HStack{
                        Text(methodRow.title)
                            .font(.title2)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        chosenMethod = methodRow
                    }
                    Button("Details") {
                        updateIndex = index
                        data = methodRow.data
                        isPresentingDetailView = true
                    }
                }
                .listRowBackground(chosenMethod == methodRow ? Color(red: 237/255, green: 213/255, blue: 140/255) : Color.white)
            }
            .onDelete { indicies in
                bakingMethodList.remove(atOffsets: indicies)
            }
            Button(action: {
                bakingMethodList.append(BreadRecipeMethod(data:data))
                updateIndex = bakingMethodList.count - 1
                isPresentingDetailView = true
            }) {
                Label("Add New Method", systemImage: "plus.circle.fill")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Method")
        .sheet(isPresented: $isPresentingDetailView) {
            NavigationView {
                BakingMethodDetailView(breadMethodData: $data)
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            Button("Cancel") {
                                isPresentingDetailView = false
                                data = BreadRecipeMethod.Data()
                            }
                        }
                        ToolbarItem(placement: .bottomBar) {
                            Button("Done") {
                                isPresentingDetailView = false
                                if bakingMethodList.indices.contains(updateIndex) {
                                    bakingMethodList[updateIndex] = BreadRecipeMethod(data: data)
                                }
                                data = BreadRecipeMethod.Data()
                                updateIndex = 0
                            }
                        }
                    }
            }
        }
    }
}

struct BakingMethodListView_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @State var breadMethod = BreadRecipeMethod()
        @State var methodList = [BreadRecipeMethod()]
        var body: some View {
            BakingMethodListView(chosenMethod: $breadMethod, bakingMethodList: $methodList)
        }
    }
    static var previews: some View {
        NavigationView{
            BindingTestHolder()
        }
    }
}
