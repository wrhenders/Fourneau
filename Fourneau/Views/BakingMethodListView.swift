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
    @State private var updateId: UUID?
    
    var body: some View {
        
        List {
            ForEach(bakingMethodList, id:\.self.id) { row in
                HStack{
                    HStack{
                        Text(row.title)
                            .font(.title2)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        chosenMethod = row
                    }
                    Button("Details") {
                        updateId = row.id
                        data = row.data
                        isPresentingDetailView = true
                    }
                }
                .listRowBackground(chosenMethod == row ? Color(red: 237/255, green: 213/255, blue: 140/255) : Color.white)
            }
            .onDelete { indicies in
                bakingMethodList.remove(atOffsets: indicies)
            }
            Button(action: {
                let newMethod = BreadRecipeMethod(data: data)
                updateId = newMethod.id
                bakingMethodList.append(newMethod)
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
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingDetailView = false
                                data = BreadRecipeMethod.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                let newMethod = BreadRecipeMethod(data: data)
                                bakingMethodList = bakingMethodList.map { $0.id == updateId ? newMethod : $0 }
                                isPresentingDetailView = false
                                data = BreadRecipeMethod.Data()
                                updateId = nil
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
