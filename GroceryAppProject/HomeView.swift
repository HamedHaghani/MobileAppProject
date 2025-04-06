//
//  HomeView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-02-28.
//  Updated by Mehmet Ali KABA
//


import SwiftUI
import CoreData

struct HomeView: View {
    @EnvironmentObject var cartManager: CartManager
    
    // Dynamic fetching of categories from Core Data.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.createdAt, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<Category>
    
    // New: Dynamic fetching of products (featured products) from Core Data.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.createdAt, ascending: false)],
        animation: .default)
    private var featuredProducts: FetchedResults<Product>
    
    // State to present the add category/product view.
    @State private var showingAddView = false
    
    // Two-column grid layout.
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Search field.
                    TextField("Search for groceries...", text: .constant(""))
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    // Categories Section.
                    Text("Categories")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: columns, spacing: 30) {
                        if categories.isEmpty {
                            Text("No categories available. Please add one.")
                                .padding()
                        } else {
                            ForEach(categories, id: \.self) { category in
                                CategoryView(category: category)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Featured Products Section.
                    Text("Featured Products")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 5)
                    
                    if featuredProducts.isEmpty {
                        Text("No products available. Please add some products.")
                            .padding(.horizontal)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(featuredProducts, id: \.id) { product in
                                    NavigationLink(
                                        destination: ProductDetailView(
                                            name: product.name ?? "",
                                            price: "$\(product.price?.stringValue ?? "0.00")",
                                            imageName: product.imageName ?? "photo"
                                        )
                                    ) {
                                        FeaturedProductCard(
                                            name: product.name ?? "",
                                            price: "$\(product.price?.stringValue ?? "0.00")",
                                            imageName: product.imageName ?? "photo"
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                        }
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Grocery Store")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddCategoryOrItemView()
                    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            }
        }
    }
}

struct CategoryView: View {
    var category: Category
    
    var body: some View {
        NavigationLink(destination: ProductListView(category: category)) {
            VStack(spacing: 8) {
                if let data = category.imageData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(15)
                        .background(Circle().fill(Color.blue.opacity(0.1)))
                        .shadow(radius: 3)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(15)
                        .background(Circle().fill(Color.blue.opacity(0.1)))
                        .shadow(radius: 3)
                }
                Text(category.name ?? "Unknown")
                    .fontWeight(.medium)
                    .padding(.top, 5)
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, minHeight: 110)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
            .padding(5)
        }
    }
}

struct FeaturedProductCard: View {
    var name: String
    var price: String
    var imageName: String
    
    @EnvironmentObject var cartManager: CartManager
    @State private var quantity: Int = 1
    
    var body: some View {
        VStack(spacing: 10) {
            CustomImage(imageName: imageName)
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding(10)
                .background(Circle().fill(Color.purple.opacity(0.1)))
                .shadow(radius: 3)
            
            Text(name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 5)
            
            Text(price)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            VStack(spacing: 5) {
                Text("Qty: \(quantity)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Stepper("", value: $quantity, in: 1...100)
                    .labelsHidden()
            }
            .padding(.top, 5)
            
            Button(action: {
                cartManager.addToCart(name: name,
                                      price: price,
                                      imageName: imageName,
                                      quantity: quantity)
                quantity = 1 // Reset after adding to cart
            }) {
                Text("Add to Cart")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.top, 5)
        }
        .padding()
        .frame(width: 140)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            .environmentObject(CartManager())
    }
}
