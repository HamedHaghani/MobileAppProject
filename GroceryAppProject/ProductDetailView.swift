//
//  GroceryAppProjectApp.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-02-28.
//
//  Updated by Mehmet Ali KABA
//

import SwiftUI

struct ProductDetailView: View {
    var name: String
    var price: String
    var imageName: String

    @EnvironmentObject var cartManager: CartManager
    @State private var quantity: Int = 1

    var body: some View {
        VStack(spacing: 20) {
            // Use CustomImage to display asset if exists.
            CustomImage(imageName: imageName)
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
            
            HStack {
                Text("Quantity: \(quantity)")
                    .font(.headline)
                Stepper("", value: $quantity, in: 1...100)
                    .labelsHidden()
            }
            .padding()

            Spacer()

            Button(action: {
                cartManager.addToCart(name: name, price: price, imageName: imageName, quantity: quantity)
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
    }
}
