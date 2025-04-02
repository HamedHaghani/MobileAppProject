import SwiftUI

struct ContentView: View {
    @StateObject var cartManager = CartManager()
    @StateObject var orderManager = OrderManager()

    var body: some View {
        ZStack {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }

                CartView()
                    .tabItem {
                        Image(systemName: "cart.fill")
                        Text("Cart")
                    }

                OrderHistoryView()
                    .tabItem {
                        Image(systemName: "list.bullet.rectangle")
                        Text("Orders")
                    }

                NavigationStack {
                    ProfileView()
                }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            }

            if let message = cartManager.notificationMessage {
                VStack {
                    Spacer()
                    Text(message)
                        .font(.caption)
                        .padding(8)
                        .background(Color.black.opacity(0.6))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.bottom, 60)
                        .shadow(radius: 4)
                }
                .transition(.opacity)
                .animation(.easeInOut, value: cartManager.notificationMessage)
            }
        }
        .environmentObject(cartManager)
        .environmentObject(orderManager)
    }
}
