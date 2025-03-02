//
//  GroceryAppProjectApp.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-02-28.
//

import SwiftUI

struct ProductDetailView: View {
    var name: String
    var price: String
    var imageName: String

    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding()
                    .background(Circle().fill(Color.blue.opacity(0.2)))
                    .shadow(radius: 3)

                Text(name)
                    .font(.title)
                    .fontWeight(.bold)

                Text(price)
                    .font(.title2)
                    .foregroundColor(.gray)

                Text("This is a detailed description of \(name). It is fresh, high quality, and perfect for your grocery needs.")
                    .padding()
                    .multilineTextAlignment(.center)

                Spacer()

                Button(action: {
                    cartManager.addToCart(name: name, price: price, imageName: imageName)
                }) {
                    Text("Add to Cart")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .navigationTitle(name)
            .navigationBarTitleDisplayMode(.inline)
            .padding()

            // ✅ Toast Notification Overlay
            if let message = cartManager.notificationMessage {
                VStack {
                    Spacer()
                    Text(message)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: cartManager.notificationMessage) 
    }
}
