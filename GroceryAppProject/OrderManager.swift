//
//  OrderManager.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-03-02.
//
import SwiftUI

class OrderManager: ObservableObject {
    // Updated orders to store cart items using imageData instead of imageName.
    @Published var orders: [[(name: String, price: String, imageData: Data?, quantity: Int)]] = []
    
    func placeOrder(cartItems: [(name: String, price: String, imageData: Data?, quantity: Int)]) {
        if !cartItems.isEmpty {
            orders.append(cartItems)
        }
    }
}
