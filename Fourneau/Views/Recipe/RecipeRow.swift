//
//  RecipeRow.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/7/22.
//

import SwiftUI

struct RecipeRow: View {
    var recipe: BreadRecipe
    
    var body: some View {
        HStack {
            Image("bread")
                .resizable()
                .scaledToFit()
                .frame(width:80, height: 80)
                .shadow(radius: 3)
                .cornerRadius(8)
            VStack (alignment: .leading, spacing: 5) {
                Text(recipe.title)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(recipe.description)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            if recipe.locked {
                Image(systemName: "lock.fill")
            }
        }
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow(recipe: BreadRecipe.sampleRecipe)
    }
}
