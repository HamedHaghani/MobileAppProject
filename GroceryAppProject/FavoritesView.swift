//
//  FavoritesView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-04-01.
//

import SwiftUI

struct FavoritesView: View {
    let favorites = [
        ("Apple", "$1.00", "applelogo"),
        ("Cheese", "$5.00", "cart"),
        ("Milk", "$3.00", "carton.fill")
    ]

    var body: some View {
        List {
            Section(header: Text("Your Favorites").font(.title2).fontWeight(.bold)) {
                if favorites.isEmpty {
                    Text("No favorites yet!")
                        .foregroundColor(.gray)
                } else {
                    ForEach(favorites, id: \.0) { item in
                        HStack {
                            Image(systemName: item.2)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.trailing, 10)

                            VStack(alignment: .leading) {
                                Text(item.0)
                                    .font(.headline)
                                Text(item.1)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
        }
        .navigationTitle("Favorites & Wishlist")
        .navigationBarTitleDisplayMode(.inline)
    }
}
