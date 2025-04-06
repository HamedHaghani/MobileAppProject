//
//  GroceryAppProjectApp.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-02-28.
//


import SwiftUI

struct ProductListView: View {
    var category: Category

    // Fetch products matching the category name (using the category attribute in Product)
    @State private var products: [Product] = []

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            if products.isEmpty {
                Text("No products found for \(category.name ?? "this category").")
                    .padding()
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(products, id: \.id) { product in
                        NavigationLink(destination: ProductDetailView(name: product.name ?? "",
                                                                        price: "$\(product.price?.stringValue ?? "0.00")",
                                                                        imageName: product.imageName ?? "photo")) {
                            VStack {
                                CustomImage(imageName: product.imageName ?? "photo")
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .padding()
                                    .background(Circle().fill(Color.blue.opacity(0.2)))
                                    .shadow(radius: 3)
                                
                                Text(product.name ?? "")
                                    .fontWeight(.medium)
                                Text("$\(product.price?.stringValue ?? "0.00")")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .padding(5)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
        .navigationTitle(category.name ?? "Products")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: loadProducts)
    }
    
    private func loadProducts() {
        // Use the category name from the selected category to fetch products.
        products = CoreDataManager.shared.fetchProducts(category: category.name ?? "")
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a dummy Category for preview purposes.
        let dummyCategory = Category(context: PersistenceController.shared.container.viewContext)
        dummyCategory.name = "Fruits"
        return NavigationView {
            ProductListView(category: dummyCategory)
        }
    }
}
