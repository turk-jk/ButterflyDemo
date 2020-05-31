//
//  Invoice+CoreDataClass.swift
//  ButterflyDemo
//
//  Created by Yacob Kazal on 31/5/20.
//  Copyright © 2020 Yacob Kazal. All rights reserved.
//
//

import Foundation
import CoreData


public class Invoice: NSManagedObject {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Invoice> {
        return NSFetchRequest<Invoice>(entityName: "Invoice")
    }
    static func getObjects(_ context : NSManagedObjectContext? = nil ,predicates : NSPredicate? = nil, sort :[NSSortDescriptor]?  = nil , fetchLimit :Int?  = nil ) -> [Invoice]  {
        let request = Invoice.createFetchRequest()
        
        request.predicate = predicates
        request.sortDescriptors = sort
        if let fetchLimit = fetchLimit {
            request.fetchLimit = fetchLimit
        }
        var result = [Invoice]()
        
        do {
            result =  try (context ?? CoreDataStack.shared.persistentContainer.viewContext).fetch(request)
        } catch {
            print("Invoice Fetch failed \(error.localizedDescription)")
        }
        return result
    }
    convenience init (_ context : NSManagedObjectContext){
        self.init(context: context)
        
        active_flag = false
        id = 0
        received_status = 0
        created = ""
        invoice_number = ""
        receipt_sent_date = ""
        last_updated = ""
        transient_identifier = ""
    }
    convenience init( context : NSManagedObjectContext , item: InvoiceStruct){
        self.init(context)
        modifyTo(context: context, item:item)
    }
    func modifyTo(context : NSManagedObjectContext ,item: InvoiceStruct){
        id = item.id
        received_status = item.received_status
        created = item.created
        invoice_number = item.invoice_number
        transient_identifier = item.transient_identifier
        active_flag = item.active_flag
        last_updated = item.last_updated
        receipt_sent_date = item.receipt_sent_date
        receipts = nil
        let receipts = item.receipts.map({Receipt.init(context: context, item: $0)})
        addToReceipts(Set(receipts))
        
    }
    static func hasInvoices(_ context : NSManagedObjectContext? = nil, id: Int) -> Invoice? {
        let predicate = NSPredicate(format: "id == %i", id)
        return getObjects(context, predicates: predicate,fetchLimit:1).first
    }
}
