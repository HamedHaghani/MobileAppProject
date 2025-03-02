//
//  GroceryAppProjectApp.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-02-28.
//




import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    let categories = [
        ("Fruits", "applelogo"),
        ("Vegetables", "leaf"),
        ("Dairy", "cup.and.saucer.fill"),
        ("Bakery", "bag.fill"),
        ("Meat", "flame.fill"),
        ("Frozen", "snowflake"),
        ("Beverages", "wineglass.fill"),
        ("Snacks", "popcorn.fill")
    ]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    let featuredProducts = [
        ("Apple", "$1.00", "applelogo"),
        ("Banana", "$0.50", "cart"),
        ("Milk", "$3.00", "carton.fill"),
        ("Bread", "$2.50", "cart"),
        ("Eggs", "$2.00", "cart"),
        ("Cheese", "$5.00", "cart"),
        ("Chicken", "$8.00", "cart"),
        ("Fish", "$10.00", "cart")
    ]
    
    var body: some View {
        ZStack{
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        
                        TextField("Search for groceries...", text: .constant(""))
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                        
                        Text("Categories")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: columns, spacing: 30) {
                            ForEach(categories, id: \.0) { category in
                                CategoryView(name: category.0, imageName: category.1)
                            }
                        }
                        .padding(.horizontal)
                        
                        
                        Text("Featured Products")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .padding(.top, 5)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(featuredProducts, id: \.0) { product in
                                    NavigationLink(destination: ProductDetailView(name: product.0, price: product.1, imageName: product.2)) {
                                        FeaturedProductCard(name: product.0, price: product.1, imageName: product.2)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                        }
                        
                        Spacer()
                    }
                }
                .navigationTitle("Grocery Store")
            }
            if let message = cartManager.notificationMessage{
                VStack{
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
    
    // Category Card
    struct CategoryView: View {
        var name: String
        var imageName: String
        
        
        var body: some View {
            NavigationLink(destination: ProductListView(categoryName: name)){
                VStack(spacing: 2) {
                    Image(systemName: imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40 , height: 40)
                        .foregroundColor(.blue.opacity(0.6))
                        .font(.largeTitle)
                        .padding(15)
                        .background(Circle().fill(Color.blue.opacity(0.1)))
                        .shadow(radius: 3)
                    
                    Text(name)
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
    
    // Product Card
    struct FeaturedProductCard: View {
        var name: String
        var price: String
        var imageName: String
        
        @EnvironmentObject var cartManager: CartManager
        
        var body: some View {
            VStack(spacing: 5 ){
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.black.opacity(0.9))
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
                
                Button(action: {
                    cartManager.addToCart(name: name, price: price, imageName: imageName)
                }) {
                    Text("Add to Cart")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top, 5)
            }
            .padding()
            .frame(width: 120)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
        }
    }
}
