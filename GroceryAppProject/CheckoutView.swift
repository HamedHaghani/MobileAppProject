//
//  CheckoutView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-03-02.
//
import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var orderManager: OrderManager

  
    var totalPrice: Double {
        cartManager.cartItems.reduce(0) { sum, item in
            let unitPrice = Double(item.price.replacingOccurrences(of: "$", with: "")) ?? 0
            return sum + (unitPrice * Double(item.quantity))
        }
    }

    @State private var orderPlaced = false

    var body: some View {
        VStack {
            Text("Order Summary")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            if cartManager.cartItems.isEmpty {
                Text("Your cart is empty.")
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(cartManager.cartItems.indices, id: \.self) { index in
                        HStack {
                            Image(systemName: cartManager.cartItems[index].imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)

                            VStack(alignment: .leading) {
                                Text(cartManager.cartItems[index].name)
                                    .font(.headline)
                                Text(cartManager.cartItems[index].price)
                                    .foregroundColor(.gray)
                                Text("Qty: \(cartManager.cartItems[index].quantity)")
                                    .foregroundColor(.gray)
                            }

                            Spacer()
                        }
                    }
                }

                Text("Total: $\(String(format: "%.2f", totalPrice))")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
            }

            Spacer()

            Button(action: {
                orderManager.placeOrder(cartItems: cartManager.cartItems)
                orderPlaced = true
                cartManager.cartItems.removeAll()
            }) {
                Text("Place Order")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(cartManager.cartItems.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .disabled(cartManager.cartItems.isEmpty)

            if orderPlaced {
                Text("Order placed successfully!")
                    .foregroundColor(.green)
                    .padding()
                    .transition(.opacity)
            }
        }
        .padding()
        .animation(.easeInOut, value: orderPlaced)
    }
}
