//
//  OrderManager.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-03-02.
//
import SwiftUI

class OrderManager: ObservableObject {
    @Published var orders: [[(name: String, price: String, imageName: String)]] = []

    func placeOrder(cartItems: [(name: String, price: String, imageName: String)]) {
        if !cartItems.isEmpty {
            orders.append(cartItems)
        }
    }
}
