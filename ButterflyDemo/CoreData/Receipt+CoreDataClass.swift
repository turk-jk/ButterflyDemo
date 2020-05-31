//
//  Receipt+CoreDataClass.swift
//  ButterflyDemo
//
//  Created by Yacob Kazal on 31/5/20.
//  Copyright © 2020 Yacob Kazal. All rights reserved.
//
//

import Foundation
import CoreData


public class Receipt: NSManagedObject {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Receipt> {
        return NSFetchRequest<Receipt>(entityName: "Receipt")
    }

    static func getObjects(_ context : NSManagedObjectContext? = nil ,predicates : NSPredicate? = nil, sort :[NSSortDescriptor]?  = nil , fetchLimit :Int?  = nil ) -> [Receipt]  {
        let request = Receipt.createFetchRequest()
        
        request.predicate = predicates
        request.sortDescriptors = sort
        if let fetchLimit = fetchLimit {
            request.fetchLimit = fetchLimit
        }
        var result = [Receipt]()
        
        do {
            result =  try (context ?? CoreDataStack.shared.persistentContainer.viewContext).fetch(request)
        } catch {
            print("Receipt Fetch failed \(error.localizedDescription)")
        }
        return result
    }
    convenience init (_ context : NSManagedObjectContext){
        self.init(context: context)
        active_flag = false
        id = 0
        created = ""
        last_updated = ""
        last_updated_user_entity_id = 0
        received_quantity = 0
        product_item_id = 0
        sent_date = ""
        transient_identifier = ""
       }
       convenience init( context : NSManagedObjectContext , item: ReceiptStruct){
           self.init(context)
           modifyTo( item:item)
       }
       func modifyTo(item: ReceiptStruct){
           id = item.id
           last_updated_user_entity_id = item.last_updated_user_entity_id
           created = item.created
           product_item_id = item.product_item_id
           transient_identifier = item.transient_identifier
           active_flag = item.active_flag
           last_updated = item.last_updated
           received_quantity = item.received_quantity
           sent_date = item.sent_date
        
       }
       static func hasReceipts(_ context : NSManagedObjectContext? = nil, id: Int) -> Receipt? {
           let predicate = NSPredicate(format: "id == %i", id)
           return getObjects(context, predicates: predicate,fetchLimit:1).first
       }
}
