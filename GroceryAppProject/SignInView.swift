//
//  SignInView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-03-02.
//  Updated by Mehmet Ali KABA
//

import SwiftUI

struct SignInView: View {
    @Binding var isUserLoggedIn: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    
    // Store the logged-in user
    @State private var loggedInUser: User?

    var body: some View {
        VStack(spacing: 30) {
            Text("Sign In")
                .font(.system(size: 36, weight: .bold))
                .padding(.bottom, 20)
            
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 18))
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                SecureField("Password", text: $password)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 18))
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            Button(action: handleSignIn) {
                Text("Log In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding(.top, 40)
    }
    
    private func handleSignIn() {
        if let user = CoreDataManager.shared.fetchUser(email: email, password: password) {
            loggedInUser = user  // ✅ Store the logged-in user
            isUserLoggedIn = true
            errorMessage = nil
        } else {
            errorMessage = "Invalid email or password"
        }
    }
}
