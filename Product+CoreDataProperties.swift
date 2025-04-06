//
//  Product+CoreDataProperties.swift
//  GroceryAppProject
//
//  Created by Mehmet Ali Kaba on 2025-03-16.
//
//
import Foundation
import CoreData

extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var category: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var imageData: Data?            // <-- NEW for storing product images
    @NSManaged public var productDescription: String? // <-- Optional product description
}

extension Product : Identifiable {

}
