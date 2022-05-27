//
//  Category+CoreDataProperties.swift
//  Venues
//
//  Created by Enas Ahmed Zaki on 27/05/2022.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String
    @NSManaged public var venue: Venue

}

extension Category : Identifiable {

}
