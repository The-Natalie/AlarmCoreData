//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by Natalie Hall on 7/29/21.
//

import Foundation
import CoreData

class AlarmController: AlarmScheduler {
    
    static var shared = AlarmController()
    var alarms: [Alarm] {
        let fetchRequest: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    // MARK: - CRUD
    func createAlarm(withTitle title: String, on isEnabled: Bool, and fireDate: Date) {
        let alarm = Alarm(title: title, isEnabled: isEnabled, fireDate: fireDate)
        
        if isEnabled {
            scheduleUserNotifications(for: alarm)
        }
        saveToPersistentStore()
    }
    
    func update(alarm: Alarm, newTitle: String, newFireDate: Date, isEnabled: Bool) {
        cancelUserNorifications(for: alarm)
        alarm.title = newTitle
        alarm.fireDate = newFireDate
        alarm.isEnabled = isEnabled
        
        if isEnabled {
            scheduleUserNotifications(for: alarm)
        }
        
        saveToPersistentStore()
    }
    
    func toggleIsEnabledFor(alarm: Alarm) {
        alarm.isEnabled = !alarm.isEnabled
        
        if alarm.isEnabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNorifications(for: alarm)
        }
        
        saveToPersistentStore()
    }
    
    func delete(alarm: Alarm) {
        cancelUserNorifications(for: alarm)
        CoreDataStack.context.delete(alarm)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
} // End of Class
