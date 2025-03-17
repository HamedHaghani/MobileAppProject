//
//  OrderHistory+CoreDataProperties.swift
//  GroceryAppProject
//
//  Created by Mehmet Ali Kaba on 2025-03-16.
//
//

import Foundation
import CoreData


extension OrderHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderHistory> {
        return NSFetchRequest<OrderHistory>(entityName: "OrderHistory")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var items: NSObject?
    @NSManaged public var orderDate: Date?
    @NSManaged public var totalAmount: NSDecimalNumber?
    @NSManaged public var user: User?

}

extension OrderHistory : Identifiable {

}
