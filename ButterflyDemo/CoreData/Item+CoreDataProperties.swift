//
//  Item+CoreDataProperties.swift
//  ButterflyDemo
//
//  Created by Yacob Kazal on 31/5/20.
//  Copyright © 2020 Yacob Kazal. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var active_flag: Bool
    @NSManaged public var id: Int
    @NSManaged public var last_updated: String
    @NSManaged public var last_updated_user_entity_id: Int
    @NSManaged public var product_item_id: Int
    @NSManaged public var quantity: Int
    @NSManaged public var transient_identifier: String
    @NSManaged public var purchaseOrder: PurchaseOrder?

}
