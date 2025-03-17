//
//  ProfileView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-02-28.
//

import SwiftUI

struct ProfileView: View {
    // Pull the userSession from the environment
    @EnvironmentObject var userSession: UserSession

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Use the currentUser’s info if available
                let userName = userSession.currentUser?.fullname ?? "Unknown User"
                let userEmail = userSession.currentUser?.email ?? "Unknown Email"
                
                // Profile Picture
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.top, 30)

                // User Info
                Text(userName)
                    .font(.title2)
                    .fontWeight(.bold)

                Text(userEmail)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Divider()
                    .padding(.horizontal, 40)

                // Settings & Options
                List {
                    NavigationLink(destination: Text("Account Settings")) {
                        HStack {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.blue)
                            Text("Account Settings")
                        }
                    }
                    NavigationLink(destination: Text("Order History")) {
                        HStack {
                            Image(systemName: "list.bullet.rectangle")
                                .foregroundColor(.blue)
                            Text("Order History")
                        }
                    }
                    Button(action: {
                        // Logout action
                        userSession.logOut()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left.circle.fill")
                                .foregroundColor(.red)
                            Text("Logout")
                                .foregroundColor(.red)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())

                Spacer()
            }
            .navigationTitle("Profile")
        }
    }
}
