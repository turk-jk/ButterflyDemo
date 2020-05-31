//
//  Cancellations+CoreDataProperties.swift
//  ButterflyDemo
//
//  Created by Yacob Kazal on 31/5/20.
//  Copyright © 2020 Yacob Kazal. All rights reserved.
//
//

import Foundation
import CoreData


extension Cancellations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cancellations> {
        return NSFetchRequest<Cancellations>(entityName: "Cancellation")
    }

    @NSManaged public var created: String
    @NSManaged public var id: Int
    @NSManaged public var last_updated_user_entity_id: Int
    @NSManaged public var ordered_quantity: Int
    @NSManaged public var product_item_id: Int
    @NSManaged public var transient_identifier: String
    @NSManaged public var relationship: PurchaseOrder?

}
