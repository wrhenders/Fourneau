//
//  ShopCard.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/20/22.
//

import SwiftUI

struct ShopCard: View {
     var shopItem: ShopItem
    
    var body: some View {
        VStack {
            Image(shopItem.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
            VStack(alignment: .leading) {
                HStack {
                    Text(shopItem.name)
                        .font(.title3)
                    Spacer()
                    Link("Shop", destination: shopItem.link)
                }
                .bold()
                .padding(.vertical, 4)
                Text(shopItem.description)
            }
            .padding()
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 8)
    }
}

struct ShopCard_Previews: PreviewProvider {
    static var previews: some View {
        ShopCard(shopItem: ShopItem.shopItems[1])
    }
}
