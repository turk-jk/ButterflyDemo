//
//  detailedView.swift
//  ButterflyDemo
//
//  Created by Yacob Kazal on 31/5/20.
//  Copyright © 2020 Yacob Kazal. All rights reserved.
//

import UIKit
class detailedView: UIViewController {
    let order: PurchaseOrder
    init(order: PurchaseOrder) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = tableView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNav()
    }
    lazy var tableView : UITableView = {
        let v = UITableView(frame: .zero, style: UITableView.Style.plain)
        v.delegate = self
        v.dataSource = self
        v.separatorStyle = .singleLine
        v.rowHeight = UITableView.automaticDimension
        v.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "Cell")
        return v
    }()
    
    func setupNav() {
        self.navigationController?.isNavigationBarHidden = false
        let addPO = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showPopup))
        self.navigationItem.rightBarButtonItem = addPO
    }
    @objc func showPopup()  {
        showAddingItemPopupWith()
    }
    func showAddingItemPopupWith(_quantity: String? = nil, _product_item_id: String? = nil) {
        let newId = (order.items?.count ?? 0) + 1
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
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (alertAction) in
            alert.dismiss(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (alertAction) in
            guard let textFields = alert.textFields else {
                return
            }
            let product_item_idTextField = textFields[0]
            let quantityTextField = textFields[1]
            guard let quantity = quantityTextField.text, !quantity.isEmpty,
                let product_item_id = product_item_idTextField.text, !product_item_id.isEmpty else{
                    
                    return
            }
            alert.dismiss(animated: true) {
                self.addItem(newId: newId, quantity: Int(quantity) ?? 0, product_item_id: Int(product_item_id) ?? 0)
            }
        }))
        self.present(alert, animated: true) {
            
        }
    }
    func addItem(newId: Int,
                   quantity: Int,
                   product_item_id: Int) {
        
        guard let moc = self.order.managedObjectContext else {
            return
        }
        
        let item =  Item(moc)
        item.id = newId
        item.product_item_id = product_item_id
        item.quantity = quantity
        let last_updated = Date().toString(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", languge: "en")
        item.last_updated = last_updated
        self.order.last_updated = last_updated
        self.order.addToItems(item)
        if let items = self.order.items,
            let index = Array(items).firstIndex(of: item){
            self.tableView.insertRows(at: [IndexPath(item: index , section: 0)], with: .right)
        }else{
            self.tableView.reloadData()
        }
        do{
            try moc.save()
        }catch{

            print("error in moc.save addItem \(error.localizedDescription)")
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK:- table datasource and delegate
extension detailedView: UITableViewDelegate, UITableViewDataSource{
    /*
     section 1 : items
     section 2 : Invoices
     section 3 : Cancellations
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return order.items?.count ?? 0
        case 1:
            return order.invoices?.count ?? 0
        case 2:
            return order.cancellations?.count ?? 0
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SubtitleTableViewCell
        
        switch indexPath.section {
        case 0:
            if let items = order.items{
                let item = Array(items)[indexPath.row]
                row.textLabel?.text = "Item id: \(item.id)"
                row.detailTextLabel?.text = "Product item Id: \(item.product_item_id), Quantity: \(item.quantity)"
            }
        case 1:
            if let items = order.invoices{
                let invoice = Array(items)[indexPath.row]
                row.textLabel?.text = "Invoice #: \(invoice.invoice_number),    Received status: \( Bool(invoice.received_status))"
            }
            
        case 2:
            if let cancellation = order.cancellations{
                let item = Array(cancellation)[indexPath.row]
                row.textLabel?.text = "Item id: \(item.id), Ordered Quantity: \(item.ordered_quantity)"
            }
        default: break
        }
        return row
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Items"
        case 1:
            return "Invoices"
        case 2:
            return "Cancellations"
        default:
            return nil
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
