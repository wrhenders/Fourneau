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
            Section {
                ForEach($bakingMethodList, id:\.self.id) { $row in
                    NavigationLink(destination: BakingMethodHostView(method: $row)) {
                        HStack{
                            Text(row.title)
                                .font(.title2)
                            Spacer()
                            if row.locked {
                                Image(systemName: "lock.fill")
                            }
                        }
                    }
                    .listRowBackground(chosenMethod == row ? Color.listSelection : Color.white)
                    .deleteDisabled(row.locked)
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
        }
        .listStyle(.grouped)
        .navigationTitle("Method List")
        .defaultNavigation
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
