//
//  SignInView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-03-02.
//

import SwiftUI

struct SignInView: View {
    @Binding var isUserLoggedIn: Bool // ✅ Update login status
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 20) {
            Text("Sign In")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            Button(action: {
                if email == "test@example.com" && password == "password123" {
                    isUserLoggedIn = true // ✅ Simulate login success
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
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }
}
