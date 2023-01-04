//
//  ShopView.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/20/22.
//

import SwiftUI

struct ShopView: View {
    @State private var shopItem: [ShopItem] = ShopItem.shopItems
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(shopItem) { item in
                    ShopCard(shopItem: item)
                        .padding()
                }
            }
            .navigationTitle("Fourneau Shop")
            .defaultNavigation
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
            ShopView()
    }
}
