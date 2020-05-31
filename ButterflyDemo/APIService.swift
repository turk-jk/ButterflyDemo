//
//  APIService.swift
//  ButterflyDemo
//
//  Created by Yacob Kazal on 31/5/20.
//  Copyright © 2020 Yacob Kazal. All rights reserved.
//

import Foundation

class APIService: NSObject {
    public class var shared: APIService {
        struct Singleton {
            static let instance = APIService()
        }
        return Singleton.instance
    }
    
    enum Result <T>{
        case Success(T)
        case Error(String)
    }
    func getData(completion: @escaping (Result<[PurchaseOrderStruct]>) -> Void) {
        let endPoint = "https://my-json-server.typicode.com/butterfly-systems/sample-data/purchase_orders"
        guard let url = URL(string:endPoint ) else { return completion(.Error("Invalid URL")) }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { return completion(.Error(error.localizedDescription)) }
            
            guard let data = data else { return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))}

            do {
                let PurchaseOrders = try JSONDecoder().decode([PurchaseOrderStruct].self, from: data)
                print("PurchaseOrders is \(PurchaseOrders.count)")
                DispatchQueue.main.async {
                    completion(.Success(PurchaseOrders))
                }
            } catch let error {
                //FIXME: handle errors
                print("catch let",error)
            }
        }
        task.resume()
    }
    
}
