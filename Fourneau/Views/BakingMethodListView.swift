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
    
    @State private var addingMethod = false
    @State var data = BreadRecipeMethod.Data()
    
    var body: some View {
        List {
            ForEach($bakingMethodList, id:\.self.id) { $row in
                NavigationLink(destination: BakingMethodHostView(method: $row)) {
                    Text(row.title)
                        .font(.title2)
                }
                .listRowBackground(chosenMethod == row ? Color(red: 237/255, green: 213/255, blue: 140/255) : Color.white)
            }
            .onDelete { indicies in
                bakingMethodList.remove(atOffsets: indicies)
            }
            Button(action: {
                addingMethod = true
            }) {
                Label("Add New Method", systemImage: "plus.circle.fill")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Method List")
        .sheet(isPresented: $addingMethod) {
            NavigationView {
                BakingMethodEditDetailView(breadMethodData: $data)
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            Button("Cancel") {
                                addingMethod = false
                            }
                        }
                        ToolbarItem(placement: .bottomBar) {
                            Button("Done") {
                                addingMethod = false
                                bakingMethodList.append(BreadRecipeMethod(data: data))
                                data = BreadRecipeMethod.Data()
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
