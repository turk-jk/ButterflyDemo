//
//  coreDataExt.swift
//  ButterflyDemo
//
//  Created by yacob jamal kazal on 30/4/19.
//  Copyright © 2019 yacob jamal kazal. All rights reserved.
//
import CoreData
import UIKit


extension NSManagedObject{

    @nonobjc public class var name :String  {
        return String(describing: self)
    }
    @nonobjc public class func createFetchRequestResult() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<NSFetchRequestResult>(entityName: self.name)
    }
    @nonobjc public class func createBatchDeleteRequest(predicates : NSPredicate? = nil ) -> NSBatchDeleteRequest {
        let FRR = createFetchRequestResult()
        FRR.predicate = predicates
        return NSBatchDeleteRequest(fetchRequest: FRR)
    }
    @nonobjc public class func count(predicates : NSPredicate? = nil ) -> Int {
        let moc = CoreDataStack.shared.persistentContainer.viewContext
        let FRR = createFetchRequestResult()
        FRR.predicate = predicates
        do{
            return try moc.count(for: FRR)

        }catch let error as NSError {
            print("count() error: \(error.localizedDescription)")
            print("count() error: \(error.userInfo)")
            return 0
        }
    }
    @nonobjc public class func deleteAll(_ context : NSManagedObjectContext? = nil , predicates : NSPredicate? = nil, done : @escaping ()->())  {
        print("before deleting entity: \(self.name) \(self.count())")
        let moc = (context ?? CoreDataStack.shared.persistentContainer.newBackgroundContext())
        moc.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        moc.perform {
            let batch = createBatchDeleteRequest(predicates: predicates)
            do {
                try moc.execute(batch)
                moc.refreshAllObjects()
                try moc.save()
                moc.refreshAllObjects()
                print("after deleting entity: \(self.name) \(self.count())")
                CoreDataStack.shared.saveContext()
                DispatchQueue.main.async {
                    done()
                }
            } catch {
                print("Failed to perform batch update: \(error)")
            }
        }
        
    }
}
