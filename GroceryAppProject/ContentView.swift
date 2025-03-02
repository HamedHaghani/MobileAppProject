import SwiftUI

struct ContentView: View {
    @StateObject var cartManager = CartManager()
    @StateObject var orderManager = OrderManager()

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .environmentObject(cartManager)
                .environmentObject(orderManager)

            CartView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }
                .environmentObject(cartManager)
                .environmentObject(orderManager)

            OrderHistoryView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Orders")
                }
                .environmentObject(orderManager)

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .environmentObject(orderManager)
    }
}
