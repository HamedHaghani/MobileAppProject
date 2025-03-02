//
//  GroceryAppProjectApp.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-02-28.
//
import SwiftUI

struct ProductListView: View {
    var categoryName: String

    let products = [
        ("Apple", "$1.00", "cart"),
        ("Banana", "$0.50", "cart"),
        ("Milk", "$3.00", "cart"),
        ("Bread", "$2.50", "cart"),
        ("Eggs", "$2.00", "cart"),
        ("Cheese", "$5.00", "cart"),
        ("Chicken", "$8.00", "cart"),
        ("Fish", "$10.00", "cart")
    ]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())] // Two-column grid

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(products, id: \.0) { product in
                    NavigationLink(destination: ProductDetailView(name: product.0, price: product.1, imageName: product.2)) {
                        VStack {
                            Image(systemName: product.2)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding()
                                .background(Circle().fill(Color.blue.opacity(0.2))) // Circular background
                                .shadow(radius: 3)

                            Text(product.0)
                                .fontWeight(.medium)
                            Text(product.1)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        .padding(5)
                    }
                    .buttonStyle(PlainButtonStyle()) // Prevents unwanted button styling
                }
            }
            .padding()
        }
        .navigationTitle(categoryName)
        .navigationBarTitleDisplayMode(.inline) // Ensures a clean title format
    }
}
