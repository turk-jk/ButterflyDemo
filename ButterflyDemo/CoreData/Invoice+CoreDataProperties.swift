//
//  Invoice+CoreDataProperties.swift
//  ButterflyDemo
//
//  Created by Yacob Kazal on 31/5/20.
//  Copyright © 2020 Yacob Kazal. All rights reserved.
//
//

import Foundation
import CoreData


extension Invoice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Invoice> {
        return NSFetchRequest<Invoice>(entityName: "Invoice")
    }

    @NSManaged public var active_flag: Bool
    @NSManaged public var created: String
    @NSManaged public var id: Int
    @NSManaged public var invoice_number: String
    @NSManaged public var last_updated: String
    @NSManaged public var receipt_sent_date: String
    @NSManaged public var received_status: Int
    @NSManaged public var transient_identifier: String
    @NSManaged public var purchaseOrder: PurchaseOrder?
    @NSManaged public var receipts: [Receipt]?

}

// MARK: Generated accessors for receipts
extension Invoice {

    @objc(addReceiptsObject:)
    @NSManaged public func addToReceipts(_ value: Receipt)

    @objc(removeReceiptsObject:)
    @NSManaged public func removeFromReceipts(_ value: Receipt)

    @objc(addReceipts:)
    @NSManaged public func addToReceipts(_ values: Set<Receipt>)

    @objc(removeReceipts:)
    @NSManaged public func removeFromReceipts(_ values: Set<Receipt>)

}
