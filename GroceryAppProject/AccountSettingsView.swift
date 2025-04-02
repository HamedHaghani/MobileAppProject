//
//  AccountSettingsView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-04-01.
//


import SwiftUI

struct AccountSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss

    @State private var fullName: String
    @State private var password: String = ""
    @State private var message: String?

    @State private var isLoggingOut = false

    var user: User

    init(user: User) {
        self.user = user
        _fullName = State(initialValue: user.fullname ?? "")
    }

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Profile")) {
                    TextField("Full Name", text: $fullName)
                }

                Section(header: Text("Password")) {
                    SecureField("New Password", text: $password)
                    Button("Update Password") {
                        user.password = password
                        user.fullname = fullName
                        CoreDataManager.shared.saveContext()
                        message = "Profile updated"
                    }
                }

                if let message = message {
                    Text(message)
                        .foregroundColor(.green)
                }
            }

            Button(action: {
                isLoggingOut = true
            }) {
                Text("Log Out")
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Account Settings")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
        }
        .fullScreenCover(isPresented: $isLoggingOut) {
            AuthView()
        }
    }
}
