//
//  Item+CoreDataClass.swift
//  ButterflyDemo
//
//  Created by Yacob Kazal on 31/5/20.
//  Copyright © 2020 Yacob Kazal. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }
    static func getObjects(_ context : NSManagedObjectContext? = nil ,predicates : NSPredicate? = nil, sort :[NSSortDescriptor]?  = nil , fetchLimit :Int?  = nil ) -> [Item]  {
           let request = Item.createFetchRequest()
           
           request.predicate = predicates
           request.sortDescriptors = sort
           if let fetchLimit = fetchLimit {
               request.fetchLimit = fetchLimit
           }
           var result = [Item]()
           
           do {
               result =  try (context ?? CoreDataStack.shared.persistentContainer.viewContext).fetch(request)
           } catch {
               print("Item Fetch failed \(error.localizedDescription)")
           }
           return result
       }
    convenience init (){
        self.init(context: CoreDataStack.shared.persistentContainer.viewContext)
    }
    convenience init (_ context : NSManagedObjectContext){
        self.init(context: context)
        active_flag = false
        id = 0
        last_updated = ""
        transient_identifier = ""
        quantity = 0
        last_updated_user_entity_id = 0
        product_item_id = 0
       }
       convenience init( context : NSManagedObjectContext , item: ItemStruct){
           self.init(context)
           modifyTo( item:item)
       }
       func modifyTo(item: ItemStruct){
           id = item.id
           active_flag = item.active_flag
           quantity = item.quantity
           last_updated_user_entity_id = item.last_updated_user_entity_id
           transient_identifier = item.transient_identifier
           last_updated = item.last_updated
           product_item_id = item.product_item_id
        
       }
       static func hasItems(_ context : NSManagedObjectContext? = nil, id: Int) -> Item? {
           let predicate = NSPredicate(format: "id == %i", id)
           return getObjects(context, predicates: predicate,fetchLimit:1).first
       }
}
