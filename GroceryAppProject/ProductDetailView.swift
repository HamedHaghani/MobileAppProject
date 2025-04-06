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
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @State private var quantity: Int = 1
    @State private var showingEditView: Bool = false

    // Observe the product so that any edits update the view.
    @ObservedObject var product: Product

    var body: some View {
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
            
            Spacer()
            
            // Add to Cart Button
            Button(action: {
                // Wrap the cart update in an async block to help avoid navigation pop issues.
                DispatchQueue.main.async {
                    let name = product.name ?? "Unnamed"
                    let price = "$\(product.price?.stringValue ?? "0.00")"
                    cartManager.addToCart(
                        name: name,
                        price: price,
                        imageData: product.imageData, // Pass image data
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
            
            Spacer()
        }
        .padding()
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

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let dummyProduct = Product(context: context)
        dummyProduct.name = "Sample Product"
        dummyProduct.price = NSDecimalNumber(string: "9.99")
        dummyProduct.productDescription = "This is a sample product."
        dummyProduct.category = "Fruits"
        return NavigationView {
            ProductDetailView(product: dummyProduct)
                .environment(\.managedObjectContext, context)
                .environmentObject(CartManager())
        }
    }
}
