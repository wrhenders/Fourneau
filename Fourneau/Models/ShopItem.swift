//
//  ShopItem.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/20/22.
//

import SwiftUI

struct ShopItem: Identifiable {
    let id: UUID = UUID()
    var name: String
    var image: String
    var description: String
    var link: URL
}

extension ShopItem {
    static let shopItems: [ShopItem] = [
        ShopItem(name: "Fourneau Grande", image: "done", description: "Bake the glossiest, crustiest loaves with Fourneau's unique steam well and precision fitting parts.", link: URL(string:"https://www.fourneauoven.com/products/fourneau-grande")!),
        ShopItem(name: "Fourneau Steam Pitcher", image: "pitcher", description: "Our gooseneck pitcher is ideal for adding a little water to your cloche or dutch oven when you want a steam boost. The lid is bamboo and the pitcher itself is polished stainless steel.", link: URL(string:"https://www.fourneauoven.com/collections/shop-all-fourneau-products/products/gooseneck-water-pitcher")!),
        ShopItem(name: "Fourneau Oval Banneton", image: "ovalBanneton", description: "These oval-shaped bannetons are fabricated with coiled cotton rope and come in a variety of decorative patterns to add a touch of fun to your kitchen.", link: URL(string:"https://www.fourneauoven.com/collections/shop-all-fourneau-products/products/fourneau-oval-banneton")!),
        ShopItem(name: "Fourneau Stencil Set", image: "stencil", description: "Whether you're baking for your family, making bread for a dinner party, or baking up gifts for your friends, decorating your bread with stencil patterns adds a special touch.", link: URL(string:"https://www.fourneauoven.com/collections/shop-all-fourneau-products/products/fourneau-stencil-set")!)
    ]
}
