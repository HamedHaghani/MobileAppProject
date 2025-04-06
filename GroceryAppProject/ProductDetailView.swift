//
//  GroceryAppProjectApp.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-02-28.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var favoritesManager: FavoritesManager
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @State private var quantity: Int = 1
    @State private var showingEditView: Bool = false

    @ObservedObject var product: Product

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Product Image
                if let data = product.imageData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .padding()
                        .background(Circle().fill(Color.blue.opacity(0.2)))
                        .shadow(radius: 3)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .padding()
                        .background(Circle().fill(Color.blue.opacity(0.2)))
                        .shadow(radius: 3)
                }

                // Product Info
                Text(product.name ?? "No Name")
                    .font(.title)
                    .fontWeight(.bold)

                Text("$\(product.price?.stringValue ?? "0.00")")
                    .font(.title2)
                    .foregroundColor(.gray)

                Text(product.productDescription ?? "No description provided.")
                    .padding()
                    .multilineTextAlignment(.center)

                // Quantity Stepper
                HStack {
                    Text("Quantity: \(quantity)")
                        .font(.headline)
                    Stepper("", value: $quantity, in: 1...100)
                        .labelsHidden()
                }
                .padding()

                // Add to Cart Button
                Button(action: {
                    DispatchQueue.main.async {
                        let name = product.name ?? "Unnamed"
                        let price = "$\(product.price?.stringValue ?? "0.00")"
                        cartManager.addToCart(
                            name: name,
                            price: price,
                            imageData: product.imageData,
                            quantity: quantity
                        )
                        quantity = 1
                    }
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

                // Add to Favorites Button
                Button(action: {
                    let name = product.name ?? "Unnamed"
                    let price = "$\(product.price?.stringValue ?? "0.00")"
                    let imageName = "photo"

                    if favoritesManager.isFavorite(name: name) {
                        favoritesManager.removeFromFavorites(name: name)
                    } else {
                        favoritesManager.addToFavorites(name: name, price: price, imageName: imageName)
                    }
                }) {
                    HStack {
                        Image(systemName: favoritesManager.isFavorite(name: product.name ?? "") ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                        Text(favoritesManager.isFavorite(name: product.name ?? "") ? "Remove from Favorites" : "Add to Favorites")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }

                // Edit Product Button
                Button(action: {
                    showingEditView = true
                }) {
                    Text("Edit Product")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                // Delete Product Button
                Button(action: deleteProduct) {
                    Text("Delete Product")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Spacer(minLength: 20) // ✅ Prevent overflow without pushing too far
            }
            .padding()
        }
        .navigationTitle(product.name ?? "Product")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingEditView) {
            EditProductView(product: product)
                .environment(\.managedObjectContext, managedObjectContext)
        }
    }

    private func deleteProduct() {
        managedObjectContext.delete(product)
        do {
            try managedObjectContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Error deleting product: \(error)")
        }
    }
}
