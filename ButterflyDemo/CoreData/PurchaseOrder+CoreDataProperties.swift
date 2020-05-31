//
//  PurchaseOrder+CoreDataProperties.swift
//  ButterflyDemo
//
//  Created by Yacob Kazal on 31/5/20.
//  Copyright © 2020 Yacob Kazal. All rights reserved.
//
//

import Foundation
import CoreData


extension PurchaseOrder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PurchaseOrder> {
        return NSFetchRequest<PurchaseOrder>(entityName: "PurchaseOrder")
    }
    
    @NSManaged public var active_flag: Bool
    @NSManaged public var approval_status: Int
    @NSManaged public var delivery_note: String
    @NSManaged public var device_key: String
    @NSManaged public var id: Int
    @NSManaged public var issue_date: String
    @NSManaged public var last_updated: String
    @NSManaged public var last_updated_user_entity_id: Int
    @NSManaged public var preferred_delivery_date: String
    @NSManaged public var purchase_order_number: String
    @NSManaged public var sent_date: String
    @NSManaged public var server_timestamp: Int
    @NSManaged public var status: Int
    @NSManaged public var supplier_id: Int
    @NSManaged public var cancellations: Set<Cancellations>?
    @NSManaged public var invoices: Set<Invoice>?
    @NSManaged public var items: Set<Item>?
    
}

    // MARK: Generated accessors for cancellations
    extension PurchaseOrder {

        @objc(addCancellationsObject:)
        @NSManaged public func addToCancellations(_ value: Cancellations)

        @objc(removeCancellationsObject:)
        @NSManaged public func removeFromCancellations(_ value: Cancellations)

        @objc(addCancellations:)
        @NSManaged public func addToCancellations(_ values: Set<Cancellations>)

        @objc(removeCancellations:)
        @NSManaged public func removeFromCancellations(_ values: Set<Cancellations>)

    }

    // MARK: Generated accessors for invoices
    extension PurchaseOrder {

        @objc(addInvoicesObject:)
        @NSManaged public func addToInvoices(_ value: Invoice)

        @objc(removeInvoicesObject:)
        @NSManaged public func removeFromInvoices(_ value: Invoice)

        @objc(addInvoices:)
        @NSManaged public func addToInvoices(_ values: Set<Invoice>)

        @objc(removeInvoices:)
        @NSManaged public func removeFromInvoices(_ values: Set<Invoice>)

    }

    // MARK: Generated accessors for items
    extension PurchaseOrder {

        @objc(addItemsObject:)
        @NSManaged public func addToItems(_ value: Item)

        @objc(removeItemsObject:)
        @NSManaged public func removeFromItems(_ value: Item)

        @objc(addItems:)
        @NSManaged public func addToItems(_ values: Set<Item>)

        @objc(removeItems:)
        @NSManaged public func removeFromItems(_ values: Set<Item>)

    }
