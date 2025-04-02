import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userSession: UserSession

    var body: some View {
        VStack(spacing: 20) {
            let userName = userSession.currentUser?.fullname ?? "Unknown User"
            let userEmail = userSession.currentUser?.email ?? "Unknown Email"

            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .padding(.top, 30)

            Text(userName)
                .font(.title2)
                .fontWeight(.bold)

            Text(userEmail)
                .font(.subheadline)
                .foregroundColor(.gray)

            Divider()
                .padding(.horizontal, 40)

            List {
                if let currentUser = userSession.currentUser {
                    NavigationLink(destination: AccountSettingsView(user: currentUser)) {
                        HStack {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.blue)
                            Text("Account Settings")
                        }
                    }
                }

                NavigationLink(destination: FavoritesView()) {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.pink)
                        Text("Favorites & Wishlist")
                    }
                }

                Button(action: {
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
