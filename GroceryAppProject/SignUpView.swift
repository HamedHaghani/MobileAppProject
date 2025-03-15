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
    @State private var fullName = ""
    
    @State private var successMessage: String?
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 30) {
            Text("Sign Up")
                .font(.system(size: 36, weight: .bold))
                .padding(.bottom, 20)
            
            VStack(spacing: 20) {
                TextField("Full Name", text: $fullName)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 18))
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.words)

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
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 18))
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            if let successMessage = successMessage {
                Text(successMessage)
                    .foregroundColor(.green)
            }
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Button(action: handleSignUp) {
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
    }
    
    private func handleSignUp() {
        guard !email.isEmpty, !password.isEmpty, password == confirmPassword else {
            errorMessage = "Passwords do not match or fields are empty."
            return
        }
        
        CoreDataManager.shared.addUser(email: email, password: password, fullName: fullName)
        successMessage = "Account created successfully!"
        errorMessage = nil
    }
}
