//
//  GroceryAppProjectApp.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-02-28.
//
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

    // Instantiate UserSession as a StateObject so it lives for the entire app session
    @StateObject var userSession = UserSession()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                AuthView()
            }
            // Inject the userSession into the environment
            .environmentObject(userSession)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
