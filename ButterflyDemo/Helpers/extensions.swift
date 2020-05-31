//
//  extensions.swift
//  ButterflyDemo
//
//  Created by Yacob Kazal on 31/5/20.
//  Copyright © 2020 Yacob Kazal. All rights reserved.
//

import Foundation

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    func toString(format : String =  "yyyy-MM-dd", languge : String = "en") -> String {
        //for more formats
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        formatter.locale = Locale(identifier: languge)
        
        return formatter.string(from: self)
    }
}
extension Bool {
    init(_ number: Int) {
        self = Bool(truncating: number as NSNumber)
    }
}
