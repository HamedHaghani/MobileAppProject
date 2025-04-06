//
//  OrderHistoryView.swift
//  GroceryAppProject
//
//  Created by HAMED HAGHANI on 2025-03-02.
//
import SwiftUI

struct OrderHistoryView: View {
    @EnvironmentObject var orderManager: OrderManager

    var body: some View {
        VStack {
            Text("Order History")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            if orderManager.orders.isEmpty {
                Text("No past orders yet.")
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(orderManager.orders.indices, id: \.self) { orderIndex in
                        Section(header: Text("Order #\(orderIndex + 1)")
                                    .font(.headline)) {
                            let orderItems = orderManager.orders[orderIndex]
                            ForEach(orderItems.indices, id: \.self) { itemIndex in
                                let item = orderItems[itemIndex]
                                HStack {
                                    if let imageData = item.imageData,
                                       let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40, height: 40)
                                    } else {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40, height: 40)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.price)
                                            .foregroundColor(.gray)
                                            .font(.subheadline)
                                        Text("Quantity: \(item.quantity)")
                                            .foregroundColor(.gray)
                                            .font(.subheadline)
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }

            Spacer()
        }
        .padding()
    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
            .environmentObject(OrderManager())
    }
}
