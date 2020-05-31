//
//  Cancellations+CoreDataClass.swift
//  ButterflyDemo
//
//  Created by Yacob Kazal on 31/5/20.
//  Copyright © 2020 Yacob Kazal. All rights reserved.
//
//

import Foundation
import CoreData


public class Cancellations: NSManagedObject {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Cancellations> {
        return NSFetchRequest<Cancellations>(entityName: "Cancellations")
    }
    static func getObjects(_ context : NSManagedObjectContext? = nil ,predicates : NSPredicate? = nil, sort :[NSSortDescriptor]?  = nil , fetchLimit :Int?  = nil ) -> [Cancellations]  {
        let request = Cancellations.createFetchRequest()
        
        request.predicate = predicates
        request.sortDescriptors = sort
        if let fetchLimit = fetchLimit {
            request.fetchLimit = fetchLimit
        }
        var result = [Cancellations]()
        
        do {
            result =  try (context ?? CoreDataStack.shared.persistentContainer.viewContext).fetch(request)
        } catch {
            print("Cancellations Fetch failed \(error.localizedDescription)")
        }
        return result
    }
    
    convenience init (_ context : NSManagedObjectContext){
        self.init(context: context)
        id = 0
        created = ""
        last_updated_user_entity_id = 0
        ordered_quantity = 0
        product_item_id = 0
        transient_identifier = ""
    }
    convenience init( context : NSManagedObjectContext , item: CancellationStruct){
        self.init(context)
        modifyTo( item:item)
    }
    func modifyTo(item: CancellationStruct){
        id = item.id
        last_updated_user_entity_id = item.last_updated_user_entity_id
        created = item.created
        ordered_quantity = item.ordered_quantity
        product_item_id = item.product_item_id
        transient_identifier = item.transient_identifier
    }
    static func hasCancellations(_ context : NSManagedObjectContext? = nil, id: Int) -> Cancellations? {
        let predicate = NSPredicate(format: "id == %i", id)
        return getObjects(context, predicates: predicate,fetchLimit:1).first
    }
}
