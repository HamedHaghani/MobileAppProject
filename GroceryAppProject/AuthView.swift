//
//  AuthView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-03-02.
//
//
//  AuthView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-03-02.
//

import SwiftUI

struct AuthView: View {
    // Use the environment object
    @EnvironmentObject var userSession: UserSession

    var body: some View {
        if userSession.isUserLoggedIn {
            // If user is logged in, show main content
            ContentView()
        } else {
            // Otherwise show the welcome + sign in/up interface
            VStack(spacing: 30) {
                Text("Welcome to GroceryApp")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Image(systemName: "cart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)

                NavigationLink(destination: SignInView()) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}
