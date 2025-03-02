//
//  CartView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-02-28.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        NavigationView { 
            VStack {
                Text("Shopping Cart")
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
                                }

                                Spacer()

                                Button(action: {
                                    cartManager.removeFromCart(index: index)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }

                   
                    NavigationLink(destination: CheckoutView()) {
                        Text("Proceed to Checkout")
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

                Spacer()
            }
            .padding()
            .navigationTitle("Your Cart")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

