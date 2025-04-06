//
//  FavoritesManager.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-04-06.
//

import SwiftUI

class FavoritesManager: ObservableObject {
    @Published var favorites: [(name: String, price: String, imageName: String)] = []
    
    func addToFavorites(name: String, price: String, imageName: String) {
        if !favorites.contains(where: { $0.name == name }) {
            favorites.append((name: name, price: price, imageName: imageName))
        }
    }
    
    func removeFromFavorites(name: String) {
        favorites.removeAll { $0.name == name }
    }
    
    func isFavorite(name: String) -> Bool {
        return favorites.contains(where: { $0.name == name })
    }
    
    func clearFavorites() {
        favorites.removeAll()
    }
}

