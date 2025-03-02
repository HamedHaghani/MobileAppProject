//
//  SignUpView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-03-02.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var successMessage: String?
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 30) {
            Text("Sign Up")
                .font(.system(size: 36, weight: .bold))
                .padding(.bottom, 20)
            
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 18))
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .contentShape(Rectangle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 18))
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .contentShape(Rectangle())
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 18))
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .contentShape(Rectangle())
            }
            .padding(.horizontal, 20)
            
            if let successMessage = successMessage {
                Text(successMessage)
                    .foregroundColor(.green)
                    .padding(.horizontal, 20)
            }
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.horizontal, 20)
            }
            
            Button(action: {
                if password == confirmPassword && !email.isEmpty {
                    successMessage = "Account created successfully!"
                } else {
                    errorMessage = "Passwords do not match or email is empty"
                }
            }) {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding(.top, 40)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}
