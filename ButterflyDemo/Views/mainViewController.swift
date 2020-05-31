//
//  mainViewController.swift
//  ButterflyDemo
//
//  Created by Yacob Kazal on 30/5/20.
//  Copyright © 2020 Yacob Kazal. All rights reserved.
//

import UIKit
import CoreData

class mainViewController: UIViewController {
    
    var fetchedResultController: FRCTableViewDataSource<PurchaseOrder>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PO List"
        self.view = tableView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNav()
        fetchPOLocally()
        fetchPOFromServer()
    }
    func fetchPOFromServer() {
        
        APIService.shared.getData { (result) in
            switch result {
            case .Success(let items):
                let moc = CoreDataStack.shared.persistentContainer.newBackgroundContext()
                moc.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                moc.perform {
                    for item in items {
                        PurchaseOrder.addItem(moc, item: item)
                    }
                    do{
                        try moc.save()
                        DispatchQueue.main.async {
                            self.fetchPOLocally()
                        }
                    }catch  let nserror as NSError {
                        //FIXME: handle error
                        print("moc.save nserror \(nserror.localizedDescription)")
                        print("moc.save nserror \(nserror.userInfo)")
                    }
                }
                
            case .Error(let message):
                //FIXME: handle error
                print("error getData: \(message)")
                break
            }
        }
    }
    //
    func fetchPOLocally() {
        let fetchRequest  = PurchaseOrder.createFetchRequest()
        let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
        fetchRequest.fetchBatchSize = 30
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        let resultsController = FRCTableViewDataSource.init(fetchRequest: fetchRequest, context: managedObjectContext, sectionNameKeyPath: nil)
        
        self.fetchedResultController = resultsController
        self.fetchedResultController.tableView = self.tableView
        self.tableView.dataSource = fetchedResultController
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch()
            self.tableView.reloadData()
        }catch{
            
        }
    }
    func setupNav() {
        self.navigationController?.isNavigationBarHidden = false
        let addPO = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPOPressed))
        self.navigationItem.rightBarButtonItem = addPO
    }
    @objc func addPOPressed() {
        let newId = (fetchedResultController.objects()?.count ?? 0) + 1
        self.navigationController?.pushViewController(addPOViewController(newId: newId), animated: true)
    }
    lazy var tableView : UITableView = {
        let v = UITableView(frame: .zero, style: UITableView.Style.plain)
        v.estimatedRowHeight = 100
        v.rowHeight = UITableView.automaticDimension
        v.delegate = self
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        v.alwaysBounceVertical = true
        v.separatorStyle = .singleLine
        v.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "Cell")
        return v
    }()
    
}

// MARK:- table datasource and delegate
extension mainViewController: FRCTableViewDelegate, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SubtitleTableViewCell
        let order = fetchedResultController.object(at: indexPath)
        row.textLabel?.text = "PO ID: \(order.id),  No. of items: \(order.items?.count ?? 0)"
        
        if let dateString = order.last_updatedDate?.toString(format: "E, d MMM yyyy HH:mm", languge: "en"){
            row.detailTextLabel?.text = "Was updated: \(dateString)"
        }
        
        row.accessoryType = .disclosureIndicator
        return row
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = fetchedResultController.object(at: indexPath)
        self.navigationController?.pushViewController(detailedView(order: order), animated: true)
    }
    
}



class SubtitleTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
