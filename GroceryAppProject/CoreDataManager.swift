//
//  CoreDataManager.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-03-15.
//

import CoreData
import SwiftUI

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let context: NSManagedObjectContext

    private init() {
        self.context = PersistenceController.shared.container.viewContext
    }
    
    // MARK: - User Operations
    
    func addUser(email: String, password: String, fullName: String) {
        let newUser = User(context: context)
        newUser.id = UUID()
        newUser.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        newUser.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        newUser.fullname = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        newUser.createdAt = Date()

        saveContext()
    }

    
    func fetchUser(email: String, password: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        do {
            let users = try context.fetch(request)
            if let user = users.first {
                // ✅ Ensure the fetched user has a valid ID before returning
                guard user.id != nil else {
                    print("⚠️ Error: User found but has no valid ID.")
                    return nil
                }
                return user
            }
        } catch {
            print("❌ Error fetching user: \(error.localizedDescription)")
        }
        return nil
    }


    // MARK: - Product Operations
    
    func addProduct(name: String, price: Decimal, imageName: String, category: String) {
        let newProduct = Product(context: context)
        newProduct.id = UUID()
        newProduct.name = name
        newProduct.price = NSDecimalNumber(decimal: price)
        newProduct.imageName = imageName
        newProduct.category = category
        newProduct.createdAt = Date()
        
        saveContext()
    }
    
    func fetchProducts(category: String) -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.predicate = NSPredicate(format: "category == %@", category)
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching products: \(error)")
            return []
        }
    }

    // MARK: - Cart Operations
    
    func addToCart(user: User, product: Product, quantity: Int) {
        let newCartItem = CartItem(context: context)
        newCartItem.id = UUID()
        newCartItem.user = user
        newCartItem.product = product
        newCartItem.quantity = Int32(quantity)
        newCartItem.addedAt = Date()
        
        saveContext()
    }
    
    func fetchCartItems(for user: User) -> [CartItem] {
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching cart items: \(error)")
            return []
        }
    }

    func removeCartItem(_ item: CartItem) {
        context.delete(item)
        saveContext()
    }
    
    // MARK: - Order History
    
    func placeOrder(user: User, cartItems: [CartItem], totalAmount: Decimal) {
        let newOrder = OrderHistory(context: context)
        newOrder.id = UUID()
        newOrder.user = user
        newOrder.totalAmount = NSDecimalNumber(decimal: totalAmount)
        newOrder.orderDate = Date()
        newOrder.items = cartItems as NSObject // Transformable attribute

        saveContext()
        
        // Clear user's cart after order
        for item in cartItems {
            context.delete(item)
        }
        saveContext()
    }
    
    func fetchOrderHistory(for user: User) -> [OrderHistory] {
        let request: NSFetchRequest<OrderHistory> = OrderHistory.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching orders: \(error)")
            return []
        }
    }
    
    // MARK: - Save Context
     func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving Core Data: \(error)")
            }
        }
    }
}

