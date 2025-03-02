//
//  SignInView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-03-02.
//
//  Updated by Mehmet Ali KABA
//

import SwiftUI

struct SignInView: View {
    @Binding var isUserLoggedIn: Bool
    @State private var email = "test@example.com" // Default email
    @State private var password = "password123" // Default password
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 30) {
            Text("Sign In")
                .font(.system(size: 36, weight: .bold))
                .padding(.bottom, 20)
            
            VStack(spacing: 20) {
                // Email Input
                TextField("Email", text: $email)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 18))
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                // Password Input
                SecureField("Password", text: $password)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 18))
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            Button(action: {
                if email == "test@example.com" && password == "password123" {
                    isUserLoggedIn = true // Simulate login success
                    errorMessage = nil
                } else {
                    errorMessage = "Invalid email or password"
                }
            }) {
                Text("Log In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            Text(errorMessage ?? " ")
                .font(.subheadline)
                .foregroundColor(.red)
                .padding(.horizontal, 20)
                .frame(height: 20, alignment: .center)
            
            Spacer()
        }
        .padding(.top, 40)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}
