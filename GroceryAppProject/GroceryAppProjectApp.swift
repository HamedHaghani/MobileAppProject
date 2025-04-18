//
//  GroceryAppProjectApp.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-02-28.
//

import SwiftUI

@main
struct GroceryAppProjectApp: App {
    let persistenceController = PersistenceController.shared

    // Instantiate the needed environment objects.
    @StateObject var userSession = UserSession()
    @StateObject var cartManager = CartManager()
    @StateObject var orderManager = OrderManager()
    @StateObject var favoritesManager = FavoritesManager() 

    var body: some Scene {
        WindowGroup {
            NavigationView {
                AuthView()
            }
            // Inject environment objects for use in all views.
            .environmentObject(userSession)
            .environmentObject(cartManager)
            .environmentObject(orderManager)
            .environmentObject(favoritesManager)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

