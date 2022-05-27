//
//  CoreDataManager.swift
//  Venues
//
//  Created by Enas Ahmed Zaki on 27/05/2022.
//

import Foundation
import UIKit
import CoreData


// This manager to handle all CoreData functionalities (Fetch, Presist and Delete)
class CoreDataManager {
    
    // Function used to save the fetched Venues to CoreData
    class func saveContext(allVenues: [VenueModel]) {
        // Flush CoreData objects and prepare it to store the new ones
        self.deleteSavedData()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if managedContext.hasChanges {
            do {
                print ("Saved")
                try managedContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
        
        // Parse VenueModels as the NSManagedObject Venue to be saved in CoreData
        for v in allVenues {
            
            let venue = Venue(context: managedContext)
            venue.name = v.name
            for cat in v.categories {
                
                let category = Category(context: managedContext)
                category.name = cat.name
                category.venue = venue
                venue.addToCategories(category)
            }
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }
    
    // Function to fetch saved Venues from CoreData
    class func loadSavedData() -> [VenueModel] {
        
        var allVenues: [VenueModel] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return allVenues
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<Venue> = Venue.fetchRequest()
        
        do {
            // fetch is performed on the NSManagedObjectContext
            let data = try managedContext.fetch(request)
            print("Got \(data.count) venues")
            
            // Parsing NSManagedObjects to be VenueModels formate
            var categories: [Category] = []
            for ven in data {
                let myFetch:NSFetchRequest<Category> = Category.fetchRequest()
                let myPredicate = NSPredicate(format: "ANY venue == %@", (ven))
                myFetch.predicate = myPredicate
                do {
                    categories = try managedContext.fetch(myFetch)
                    allVenues.append( VenueModel.init(categories: categories.map({ CategoriesModel.init(name: $0.name)}), name: ven.name))
                    
                }catch{
                    print(error)
                }
            }
            
        } catch {
            print("Fetch failed")
        }
        
        return allVenues
    }
    
    // Function to delete all data in CoreData
    class func deleteSavedData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Venue")
        
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(batchDeleteRequest)
            
        } catch {
            print("Delete failed")
        }
    }
    
}
