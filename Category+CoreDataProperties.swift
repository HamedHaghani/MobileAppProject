//
//  Category+CoreDataProperties.swift
//  GroceryAppProject
//
//  Created by Mehmet Ali Kaba on 2025-04-05.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var createdAt: Date?

}

extension Category : Identifiable {

}
