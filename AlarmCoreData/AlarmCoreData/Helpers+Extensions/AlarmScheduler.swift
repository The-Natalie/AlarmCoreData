//
//  AlarmScheduler.swift
//  AlarmCoreData
//
//  Created by Natalie Hall on 8/1/21.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: AnyObject {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNorifications(for alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm){
        let content = UNMutableNotificationContent()
        
        content.title = "Attention!!!"
        content.body = "Your \(alarm.title!) alarm is going off!"
        content.sound = UNNotificationSound.default

        let components = Calendar.current.dateComponents([.month, .day, .year, .hour, .minute, .second], from: alarm.fireDate!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuidString!, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error{
                print("Error scheduling local user notifications \(error.localizedDescription)  :  \(error)")
            }
        }
    }
    
    func cancelUserNorifications(for alarm: Alarm) {
        guard let id = alarm.uuidString else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
