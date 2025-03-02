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
                        Section(header: Text("Order #\(orderIndex + 1)").font(.headline)) {
                            ForEach(orderManager.orders[orderIndex], id: \.name) { item in
                                HStack {
                                    Image(systemName: item.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)

                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.price)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Spacer()
        }
        .padding()
    }
}
