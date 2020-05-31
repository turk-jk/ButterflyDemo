//
//  PurchaseOrderStruct.swift
//  ButterflyDemo
//
//  Created by Yacob Kazal on 31/5/20.
//  Copyright © 2020 Yacob Kazal. All rights reserved.
//

import UIKit

struct PurchaseOrderStruct : Codable {
    var active_flag : Bool
    var approval_status : Int
    var delivery_note : String
    var device_key : String
    var id : Int
    var issue_date : String
    var last_updated : String
    var last_updated_user_entity_id : Int
    var preferred_delivery_date : String
    var purchase_order_number : String
    var sent_date : String
    var server_timestamp : Int
    var status : Int
    var supplier_id : Int
    var items : [ItemStruct]
    var invoices : [InvoiceStruct]
    var cancellations : [CancellationStruct]
    
    //keys of the items in newsFeedResponse
    enum CodingKeys: String, CodingKey {
        case active_flag = "active_flag"
        case approval_status = "approval_status"
        case delivery_note = "delivery_note"
        case device_key = "device_key"
        case id = "id"
        case issue_date = "issue_date"
        case last_updated = "last_updated"
        case last_updated_user_entity_id = "last_updated_user_entity_id"
        case preferred_delivery_date = "preferred_delivery_date"
        case purchase_order_number = "purchase_order_number"
        case sent_date = "sent_date"
        case server_timestamp = "server_timestamp"
        case status = "status"
        case supplier_id = "supplier_id"
        case items = "items"
        case invoices = "invoices"
        case cancellations = "cancellations"
    }
    
    // init the newsFeedResponse with default values
    init(from decoder: Decoder) throws {
        self.init()
        do{
            let values = try decoder.container(keyedBy: CodingKeys.self)
            active_flag = try values.decodeIfPresent(Bool.self, forKey: .active_flag) ?? false
            approval_status = try values.decodeIfPresent(Int.self, forKey: .approval_status) ?? 0
            last_updated_user_entity_id = try values.decodeIfPresent(Int.self, forKey: .last_updated_user_entity_id) ?? 0
            server_timestamp = try values.decodeIfPresent(Int.self, forKey: .server_timestamp) ?? 0
            status = try values.decodeIfPresent(Int.self, forKey: .status) ?? 0
            supplier_id = try values.decodeIfPresent(Int.self, forKey: .supplier_id) ?? 0
            id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
            
            delivery_note = try values.decodeIfPresent(String.self, forKey: .delivery_note) ?? ""
            device_key = try values.decodeIfPresent(String.self, forKey: .device_key) ?? ""
            issue_date = try values.decodeIfPresent(String.self, forKey: .issue_date) ?? ""
            last_updated = try values.decodeIfPresent(String.self, forKey: .last_updated) ?? ""
            preferred_delivery_date = try values.decodeIfPresent(String.self, forKey: .preferred_delivery_date) ?? ""
            purchase_order_number = try values.decodeIfPresent(String.self, forKey: .purchase_order_number) ?? ""
            sent_date = try values.decodeIfPresent(String.self, forKey: .sent_date) ?? ""
            
            
            items = try values.decodeIfPresent([ItemStruct].self, forKey: .items) ?? [ItemStruct]()
            invoices = try values.decodeIfPresent([InvoiceStruct].self, forKey: .invoices) ?? [InvoiceStruct]()
            cancellations = try values.decodeIfPresent([CancellationStruct].self, forKey: .cancellations) ?? [CancellationStruct]()
            
        }catch{
            print("PurchaseOrderStruct error",error.localizedDescription)
        }
    }
    init() {
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
        items = [ItemStruct]()
        invoices = [InvoiceStruct]()
        cancellations = [CancellationStruct]()
    }
    
    var last_updatedDate: Date?{
        let dateFormatter = DateFormatter()
        //2020-05-07T09:32:28.213Z
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: last_updated)
    }
}


struct ItemStruct : Codable {
    
    var active_flag: Bool
    var id: Int
    var last_updated_user_entity_id: Int
    var product_item_id: Int
    var quantity: Int
    var last_updated: String
    var transient_identifier: String
    
    //keys of the items in newsFeedResponse
    enum CodingKeys: String, CodingKey {
        
        case active_flag = "active_flag"
        case id = "id"
        case last_updated = "last_updated"
        case last_updated_user_entity_id = "last_updated_user_entity_id"
        case product_item_id = "product_item_id"
        case quantity = "quantity"
        case transient_identifier = "transient_identifier"
    }
    
    // init the newsFeedResponse with default values
    init(from decoder: Decoder) throws {
        self.init()
        do{
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            active_flag = try values.decodeIfPresent(Bool.self, forKey: .active_flag) ?? false
            last_updated_user_entity_id = try values.decodeIfPresent(Int.self, forKey: .last_updated_user_entity_id) ?? 0
            id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
            product_item_id = try values.decodeIfPresent(Int.self, forKey: .product_item_id) ?? 0
            quantity = try values.decodeIfPresent(Int.self, forKey: .quantity) ?? 0
            last_updated = try values.decodeIfPresent(String.self, forKey: .last_updated) ?? ""
            transient_identifier = try values.decodeIfPresent(String.self, forKey: .transient_identifier) ?? ""
        }catch{
            print("ItemStruct error",error.localizedDescription)
        }
    }
    init() {
        active_flag = false
        last_updated_user_entity_id = 0
        id = 0
        product_item_id = 0
        quantity = 0
        last_updated = ""
        transient_identifier = ""
    }
    
    
}
struct CancellationStruct : Codable {
    var created: String
    var id: Int
    var last_updated_user_entity_id: Int
    var ordered_quantity: Int
    var product_item_id: Int
    var transient_identifier: String
    
    //keys of the items in newsFeedResponse
    enum CodingKeys: String, CodingKey {
        case created = "created"
        case id = "id"
        case last_updated_user_entity_id = "last_updated_user_entity_id"
        case ordered_quantity = "ordered_quantity"
        case product_item_id = "product_item_id"
        case transient_identifier = "transient_identifier"
    }
    
    // init the newsFeedResponse with default values
    init(from decoder: Decoder) throws {
        self.init()
        do{
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
            last_updated_user_entity_id = try values.decodeIfPresent(Int.self, forKey: .last_updated_user_entity_id) ?? 0
            ordered_quantity = try values.decodeIfPresent(Int.self, forKey: .ordered_quantity) ?? 0
            product_item_id = try values.decodeIfPresent(Int.self, forKey: .product_item_id) ?? 0
            
            transient_identifier = try values.decodeIfPresent(String.self, forKey: .transient_identifier) ?? ""
            created = try values.decodeIfPresent(String.self, forKey: .created) ?? ""
            
        }catch{
            print("CancellationStruct error",error.localizedDescription)
        }
    }
    init() {
        last_updated_user_entity_id = 0
        id = 0
        ordered_quantity = 0
        product_item_id = 0
        
        transient_identifier = ""
        created = ""
    }
    
    
}


struct InvoiceStruct : Codable {
    var active_flag: Bool
    var created: String
    var id: Int
    var received_status: Int
    var invoice_number: String
    var last_updated: String
    var receipt_sent_date: String
    var transient_identifier: String
    var receipts: [ReceiptStruct]
    
    //keys of the items in newsFeedResponse
    enum CodingKeys: String, CodingKey {

        case active_flag = "active_flag"
        case created = "created"
        case id = "id"
        case invoice_number = "invoice_number"
        case last_updated = "last_updated"
        case receipt_sent_date = "receipt_sent_date"
        case received_status = "received_status"
        case transient_identifier = "transient_identifier"
        case receipts = "receipts"
    }
    
    // init the newsFeedResponse with default values
    init(from decoder: Decoder) throws {
        self.init()
        do{
            let values = try decoder.container(keyedBy: CodingKeys.self)

            active_flag = try values.decodeIfPresent(Bool.self, forKey: .active_flag) ?? false
            created = try values.decodeIfPresent(String.self, forKey: .created) ?? ""
            id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
            received_status = try values.decodeIfPresent(Int.self, forKey: .received_status) ?? 0
            invoice_number = try values.decodeIfPresent(String.self, forKey: .invoice_number) ?? ""
            last_updated = try values.decodeIfPresent(String.self, forKey: .last_updated) ?? ""
            receipt_sent_date = try values.decodeIfPresent(String.self, forKey: .receipt_sent_date) ?? ""
            transient_identifier = try values.decodeIfPresent(String.self, forKey: .transient_identifier) ?? ""
            
            receipts = try values.decodeIfPresent([ReceiptStruct].self, forKey: .receipts) ?? [ReceiptStruct]()
        }catch{
            print("InvoiceStruct error",error.localizedDescription)
        }
    }
    init() {
        active_flag = false
        created = ""
        id = 0
        received_status = 0
        invoice_number = ""
        last_updated = ""
        receipt_sent_date = ""
        transient_identifier = ""
        receipts = [ReceiptStruct]()

    }
    
    
}

struct ReceiptStruct : Codable {
    var active_flag: Bool
    var created: String
    var id: Int
    var last_updated: String
    var last_updated_user_entity_id: Int
    var product_item_id: Int
    var received_quantity: Int
    var sent_date: String
    var transient_identifier: String
    
    //keys of the items in newsFeedResponse
    enum CodingKeys: String, CodingKey {
        
        case active_flag = "active_flag"
        case created = "created"
        case id = "id"
        case last_updated = "last_updated"
        case last_updated_user_entity_id = "last_updated_user_entity_id"
        case product_item_id = "product_item_id"
        case received_quantity = "received_quantity"
        case sent_date = "sent_date"
        case transient_identifier = "transient_identifier"
    }
    
    // init the newsFeedResponse with default values
    init(from decoder: Decoder) throws {
        self.init()
        do{
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            active_flag = try values.decodeIfPresent(Bool.self, forKey: .active_flag) ?? false
            last_updated_user_entity_id = try values.decodeIfPresent(Int.self, forKey: .last_updated_user_entity_id) ?? 0
            id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
            product_item_id = try values.decodeIfPresent(Int.self, forKey: .product_item_id) ?? 0
            created = try values.decodeIfPresent(String.self, forKey: .created) ?? ""
            received_quantity = try values.decodeIfPresent(Int.self, forKey: .received_quantity) ?? 0
            last_updated = try values.decodeIfPresent(String.self, forKey: .last_updated) ?? ""
            sent_date = try values.decodeIfPresent(String.self, forKey: .sent_date) ?? ""
            transient_identifier = try values.decodeIfPresent(String.self, forKey: .transient_identifier) ?? ""
        }catch{
            print("ReceiptStruct error",error.localizedDescription)
        }
    }
    init() {
        active_flag = false
        last_updated_user_entity_id = 0
        id = 0
        product_item_id = 0
        received_quantity = 0
        created = ""
        last_updated = ""
        transient_identifier = ""
        sent_date = ""
        
    }
    
    
}
