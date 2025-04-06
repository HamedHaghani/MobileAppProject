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
    @Environment(\.presentationMode) var presentationMode

    // Compute the total price from the cart items.
    var totalPrice: Double {
        cartManager.cartItems.reduce(0) { sum, item in
            let unitPrice = Double(item.price.replacingOccurrences(of: "$", with: "")) ?? 0
            return sum + (unitPrice * Double(item.quantity))
        }
    }

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
                            // Display product image from imageData if available.
                            if let data = cartManager.cartItems[index].imageData,
                               let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(cartManager.cartItems[index].name)
                                    .font(.headline)
                                Text(cartManager.cartItems[index].price)
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                Text("Qty: \(cartManager.cartItems[index].quantity)")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                            Spacer()
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(PlainListStyle())

                Text("Total: $\(String(format: "%.2f", totalPrice))")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
            }

            Spacer()

            // When Place Order is tapped, the order is saved and the checkout view is dismissed.
            Button(action: {
                orderManager.placeOrder(cartItems: cartManager.cartItems)
                cartManager.cartItems.removeAll()
                presentationMode.wrappedValue.dismiss()
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
        }
        .padding()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(CartManager())
            .environmentObject(OrderManager())
    }
}
