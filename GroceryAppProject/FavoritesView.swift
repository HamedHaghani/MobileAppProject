//
//  FavoritesView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-04-01.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Favorites")
                .font(.title2)
                .fontWeight(.bold)
                .padding()

            if favoritesManager.favorites.isEmpty {
                Spacer()
                Text("No favorites yet!")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            } else {
                List {
                    ForEach(favoritesManager.favorites, id: \.name) { item in
                        HStack {
                            Image(systemName: item.imageName)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.trailing, 10)

                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.price)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            Button(action: {
                                favoritesManager.removeFromFavorites(name: item.name)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Favorites & Wishlist")
    }
}
