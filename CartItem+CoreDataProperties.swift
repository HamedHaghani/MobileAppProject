//
//  CartItem+CoreDataProperties.swift
//  GroceryAppProject
//
//  Created by Mehmet Ali Kaba on 2025-03-16.
//
//

import Foundation
import CoreData


extension CartItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItem> {
        return NSFetchRequest<CartItem>(entityName: "CartItem")
    }

    @NSManaged public var addedAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var quantity: Int32
    @NSManaged public var product: Product?
    @NSManaged public var user: User?

}

extension CartItem : Identifiable {

}
