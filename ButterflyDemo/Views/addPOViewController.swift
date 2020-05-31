//
//  addPOViewController.swift
//  ButterflyDemo
//
//  Created by Yacob Kazal on 31/5/20.
//  Copyright © 2020 Yacob Kazal. All rights reserved.
//

import UIKit
import Eureka

class addPOViewController: FormViewController {
    let newId: Int
    
    /// init addPOViewController
    /// - Parameter newId: the new ID of the PO
    init(newId: Int) {
        self.newId = newId
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Purchase Order"
        setupForm()
    }
    func setupForm() {
        
        form +++ Section("Item with new Id is : \(newId)")
            <<< IntRow("supplier_id"){ row in
                row.title = "Supplier id"
                row.placeholder = "Enter supplier_id"
            }
            <<< IntRow("purchase_order_number"){ row in
                row.title = "Purchase Order Number"
                row.placeholder = "Enter purchase_order_number"
            }
            
            <<< SwitchRow("status", { (row) in
                row.title = "Status"
                row.value = false
            })
            <<< SwitchRow("active_flag", { (row) in
                row.title = "Active flag"
                row.value = false
            })
            <<< SwitchRow("approval_status", { (row) in
                row.title = "Approval Status"
                row.value = false
            })
            
            +++ MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],header: "Add Items",footer: "Insert Item a 'Add Item' (Add New Tag) button row as last cell.") {
                $0.addButtonProvider = { section in
                    return ButtonRow(){
                        $0.title = "Add New Item"
                    }
                }
                $0.multivaluedRowToInsertAt = { index in
                    
                    let row = LabelRow("Item\(index)")
                    let newId = index + 1
                    self.showAddingItemPopupWith(newId: newId, row: row,  _quantity:nil, _product_item_id:  nil)
                    return row
                }
            }
            +++ Section("Delivery Note")
            <<< TextAreaRow("delivery_note")
            <<< DateTimeRow("preferred_delivery_date", {
                $0.title = "Preferred Delivery date"
            })
            
            +++ Section()
            <<< ButtonRow("button", { (button) in
                button.title = "Add"
            }).onCellSelection({ (button, row) in
                self.addPO()
            })
        
    }
    /// Adding purchase order
    func addPO() {
        let moc = CoreDataStack.shared.persistentContainer.viewContext
        let po = PurchaseOrder(context: moc)
        po.id = self.newId
        let valuesDictionary = self.form.values()
        
        if let active_flag = valuesDictionary["active_flag"] as? Bool{
            po.active_flag = active_flag
        }
        if let status = valuesDictionary["status"] as? Bool{
            po.status = status ? 1 : 0
        }
        if let preferred_delivery_date = valuesDictionary["preferred_delivery_date"] as? Date{
            po.preferred_delivery_date = preferred_delivery_date.toString(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", languge: "en")
        }
        if let delivery_note = valuesDictionary["delivery_note"] as? String{
            po.delivery_note = delivery_note
        }
        if let purchase_order_number = valuesDictionary["purchase_order_number"] as? String{
            po.purchase_order_number = purchase_order_number
        }
        if let supplier_id = valuesDictionary["supplier_id"] as? String{
            po.supplier_id = Int(supplier_id) ?? 0
        }
        if let approval_status = valuesDictionary["approval_status"] as? Bool{
            po.approval_status = approval_status ? 1 : 0
        }
        po.last_updated = Date().toString(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", languge: "en")

        // adding items to the PO
        let itemRows = self.form.rows.filter({type(of: $0) == LabelRow.self }) as! [LabelRow]
        var items = [Item]()
        for itemRow in itemRows {
            let newId = (itemRow.tag ?? "").digits.int + 1
            let title = itemRow.title ?? ""
            let component = title.split(separator: ",")
            let quantity = String(component[0]).digits.int
            let product_item_id = String(component[1]).digits.int
            let item =  Item.init(moc)
            item.id = newId
            item.product_item_id = product_item_id
            item.quantity = quantity
            let last_updated = Date().toString(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", languge: "en")
            item.last_updated = last_updated
            items.append(item)
        }
        po.addToItems(Set(items))
        do{
            moc.insert(po)
            try moc.save()
            self.navigationController?.popViewController(animated: true)
        }catch let error as NSError{
            //FIXME: handle error
            print("error moc.save addPO localizedDescription \(error.localizedDescription)")
        }
    }
    
    /// show a pop up with textfeilds to add new items
    /// - Parameters:
    ///   - newId: is the new id of the item in the PO
    ///   - row: row that is holding the details new item
    ///   - _quantity: quantity of the item defailt to nil, set it with inital value
    ///   - _product_item_id:  product item id defailt to nil, set it with inital value
    func showAddingItemPopupWith(newId: Int, row: LabelRow,  _quantity: String? = nil, _product_item_id: String? = nil) {
        
        let alert = UIAlertController(title: "Add New Item!", message: """
            Enter Product item id and Quantity
            New Item Id: \(newId)
            """, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Product Item Id"
            textField.text = _product_item_id
            textField.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Quantity"
            textField.text = _quantity
            textField.keyboardType = .numberPad
            
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (alertAction) in
            guard let textFields = alert.textFields else { return }
            
            let product_item_idTextField = textFields[0]
            let quantityTextField = textFields[1]
            guard let quantity = quantityTextField.text, !quantity.isEmpty,
                let product_item_id = product_item_idTextField.text, !product_item_id.isEmpty else{
                    print("no quantity or no product_item_id or both were not entered")
                    let alert2 = UIAlertController(title: "erro", message: "please Enter Product item id and Quantity ", preferredStyle: .alert)
                    alert2.addAction(UIAlertAction(title: "ok", style: .default, handler: { (_) in
                        self.showAddingItemPopupWith(newId: newId, row: row,  _quantity:quantityTextField.text, _product_item_id:  product_item_idTextField.text)
                    }))
                    self.present(alert2, animated: true)
                    return
            }
            alert.dismiss(animated: true) {
                row.title = "Product item id: \(product_item_id), Quantity: \(Int(quantity) ?? 0)"
                row.reload()
            }
        }))
        self.present(alert, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    var int: Int{
        return Int(self) ?? 0
    }
}
