//
//  Venue+CoreDataProperties.swift
//  Venues
//
//  Created by Enas Ahmed Zaki on 27/05/2022.
//
//

import Foundation
import CoreData


extension Venue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Venue> {
        return NSFetchRequest<Venue>(entityName: "Venue")
    }

    @NSManaged public var name: String
    @NSManaged public var categories: Set<Category>

}

// MARK: Generated accessors for categories
extension Venue {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: Category)

}

extension Venue : Identifiable {

}
