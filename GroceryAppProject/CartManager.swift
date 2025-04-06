//
//  CartManager.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-02-28.
//

import SwiftUI

class CartManager: ObservableObject {
    // Updated: now storing imageData instead of imageName.
    @Published var cartItems: [(name: String, price: String, imageData: Data?, quantity: Int)] = []
    @Published var notificationMessage: String?

    func addToCart(name: String, price: String, imageData: Data?, quantity: Int) {
        if let index = cartItems.firstIndex(where: { $0.name == name }) {
            cartItems[index].quantity += quantity
        } else {
            cartItems.append((name: name, price: price, imageData: imageData, quantity: quantity))
        }
        showNotification(message: "\(name) added to cart!")
    }

    func removeFromCart(index: Int) {
        guard index < cartItems.count else { return }
        let itemName = cartItems[index].name
        cartItems.remove(at: index)
        showNotification(message: "\(itemName) removed from cart!")
    }
    
    private func showNotification(message: String) {
        notificationMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.notificationMessage = nil
        }
    }
}
