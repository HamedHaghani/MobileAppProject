//
//  CartView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-02-28.
//
// Updated by Mehmet Ali KABA
import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        NavigationView {
            VStack {
                Text("Your Shopping Cart")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()

                if cartManager.cartItems.isEmpty {
                    Text("Your cart is empty. Start adding some tasty items!")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    List {
                        ForEach(cartManager.cartItems.indices, id: \.self) { index in
                            HStack(spacing: 15) {
                                // Display image from imageData if available; otherwise, use fallback image.
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
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(cartManager.cartItems[index].name)
                                        .font(.headline)
                                    Text(cartManager.cartItems[index].price)
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                    Text("Quantity: \(cartManager.cartItems[index].quantity)")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    cartManager.removeFromCart(index: index)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .listStyle(PlainListStyle())

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

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
