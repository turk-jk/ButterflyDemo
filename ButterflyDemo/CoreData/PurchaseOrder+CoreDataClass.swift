//
//  PurchaseOrder+CoreDataClass.swift
//  ButterflyDemo
//
//  Created by Yacob Kazal on 31/5/20.
//  Copyright © 2020 Yacob Kazal. All rights reserved.
//
//

import Foundation
import CoreData


public class PurchaseOrder: NSManagedObject {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<PurchaseOrder> {
        return NSFetchRequest<PurchaseOrder>(entityName: "PurchaseOrder")
    }
    static func getObjects(_ context : NSManagedObjectContext? = nil ,predicates : NSPredicate? = nil, sort :[NSSortDescriptor]?  = nil , fetchLimit :Int?  = nil ) -> [PurchaseOrder]  {
        let request = PurchaseOrder.createFetchRequest()
        
        request.predicate = predicates
        request.sortDescriptors = sort
        if let fetchLimit = fetchLimit {
            request.fetchLimit = fetchLimit
        }
        var result = [PurchaseOrder]()
        
        do {
            result =  try (context ?? CoreDataStack.shared.persistentContainer.viewContext).fetch(request)
        } catch {
            print("PurchaseOrder Fetch failed \(error.localizedDescription)")
        }
        return result
    }
    convenience init (){
        self.init(context: CoreDataStack.shared.persistentContainer.viewContext)
    }
    
    convenience init (_ context : NSManagedObjectContext){
        self.init(context: context)
        active_flag = false
        approval_status = 0
        delivery_note = ""
        device_key = ""
        id = 0
        issue_date = ""
        last_updated = ""
        last_updated_user_entity_id = 0
        preferred_delivery_date = ""
        purchase_order_number = ""
        sent_date = ""
        server_timestamp = 0
        status = 0
        supplier_id = 0
    }
    convenience init( context : NSManagedObjectContext , item: PurchaseOrderStruct){
        self.init(context)
        modifyTo( context, item:item)
    }
    static func addItem(_ context : NSManagedObjectContext, item: PurchaseOrderStruct){
        if let order = hasOrder(context,id: item.id){
            /*
             The data must persist across sessions and it must not be overridden by the data in server unless the last updated time in the server is greater than the last updated time on the local device.
             */
            if let old_last_updated =  order.last_updatedDate,
                let new_last_updated =  item.last_updatedDate,
                new_last_updated > old_last_updated{
                order.modifyTo( context, item:item)
            }
        }else{
            _ = PurchaseOrder.init(context: context, item: item)
        }
    }
    func modifyTo(_ context : NSManagedObjectContext, item: PurchaseOrderStruct){
        active_flag = item.active_flag
        approval_status = item.approval_status
        delivery_note = item.delivery_note
        device_key = item.device_key
        id = item.id
        issue_date = item.issue_date
        last_updated = item.last_updated
        last_updated_user_entity_id = item.last_updated_user_entity_id
        preferred_delivery_date = item.preferred_delivery_date
        purchase_order_number = item.purchase_order_number
        sent_date = item.sent_date
        server_timestamp = item.server_timestamp
        status = item.status
        supplier_id = item.supplier_id
        cancellations = nil
        let cancellations = item.cancellations.map({Cancellations.init(context: context, item: $0)})
        addToCancellations(Set(cancellations))
        
        invoices = nil
        let invoices = item.invoices.map({Invoice.init(context: context, item: $0)})
        addToInvoices(Set(invoices))
        
        items = nil
        let items = item.items.map({Item.init(context: context, item: $0)})
        addToItems(Set(items))

        
    }

    static func hasOrder(_ context : NSManagedObjectContext? = nil, id: Int) -> PurchaseOrder? {
        let predicate = NSPredicate(format: "id == %i", id)
        return getObjects(context, predicates: predicate,fetchLimit:1).first
    }
    var last_updatedDate : Date?{
        let dateFormatter = DateFormatter()
        //2020-05-07T09:32:28.213Z
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: last_updated)
    }
}
extension PurchaseOrder {
    public override var description : String {
        return """
        
        
        id:  \(id)
        active_flag: \(active_flag)
        approval_status:  \(approval_status)
        delivery_note:  \(String(describing: delivery_note))
        device_key:  \(String(describing: device_key))
        issue_date:  \(String(describing: issue_date))
        last_updated:  \(String(describing: last_updated))
        last_updated_user_entity_id:  \(last_updated_user_entity_id)
        preferred_delivery_date:  \(String(describing: preferred_delivery_date))
        purchase_order_number:  \(String(describing: purchase_order_number))
        sent_date:  \(String(describing: sent_date))
        server_timestamp:  \(server_timestamp)
        status:  \(status)
        supplier_id:  \(supplier_id)
        cancellations?.count:  \(String(describing: cancellations?.count))
        """
    }

    public override var debugDescription : String {
       return "debug test"
   }
}
