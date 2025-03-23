//
//  UserSession.swift
//  GroceryAppProject
//
//  Created by Mehmet Ali Kaba on 2025-03-16.
//
import SwiftUI
import Combine

class UserSession: ObservableObject {
    @Published var currentUser: User? = nil
    @Published var isUserLoggedIn: Bool = false
    
    func logIn(user: User) {
        currentUser = user
        isUserLoggedIn = true
    }
    
    func logOut() {
        currentUser = nil
        isUserLoggedIn = false
    }
}
