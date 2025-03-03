//
//  GroceryAppProjectApp.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-02-28.
//
import SwiftUI

struct ProductListView: View {
    var categoryName: String

    // For demonstration we are using the same products.
    let products = [
        ("Apple", "$1.00", "Apple"),
        ("Banana", "$0.50", "Banana"),
        ("Milk", "$3.00", "Milk"),
        ("Bread", "$2.50", "Bread"),
        ("Eggs", "$2.00", "Eggs"),
        ("Cheese", "$5.00", "Cheese"),
        ("Chicken", "$8.00", "Chicken"),
        ("Fish", "$10.00", "Fish")
    ]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())] // Two-column grid

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(products, id: \.0) { product in
                    NavigationLink(destination: ProductDetailView(name: product.0, price: product.1, imageName: product.2)) {
                        VStack {
                            // Use CustomImage here as well.
                            CustomImage(imageName: product.2)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding()
                                .background(Circle().fill(Color.blue.opacity(0.2)))
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
