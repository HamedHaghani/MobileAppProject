//
//  AuthView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-03-02.
//

import SwiftUI

struct AuthView: View {
    @State private var isUserLoggedIn = false 

    var body: some View {
        if isUserLoggedIn {
            ContentView()
        } else {
            VStack(spacing: 30) {
                Text("Welcome to GroceryApp")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Image(systemName: "cart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)

                NavigationLink(destination: SignInView(isUserLoggedIn: $isUserLoggedIn)) {
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
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}
