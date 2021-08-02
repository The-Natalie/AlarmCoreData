//
//  Alarm+Convenience.swift
//  AlarmCoreData
//
//  Created by Natalie Hall on 7/29/21.
//

import CoreData

extension Alarm {
    @discardableResult
    convenience init(title: String, isEnabled: Bool = true, fireDate: Date, uuidString: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.isEnabled = isEnabled
        self.fireDate =  fireDate
        self.uuidString = uuidString
    }
}