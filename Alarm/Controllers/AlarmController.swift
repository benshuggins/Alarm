//
//  AlarmController.swift
//  Alarm
//
//  Created by User on 1/28/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import UserNotifications

// step 1

protocol AlarmScheduler: class {
    func scheduleUserNotofications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}


extension AlarmScheduler {
    
    func scheduleUserNotofications(for alarm: Alarm) {
        
        let content = UNMutableNotificationContent()
        content.title = "Time to get up"
        content.body = "Your alarm named \(alarm.name) is going off!"
        //content.sound = UNNotificationSound.default()
        
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: alarm.fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error{
                print("Error scheduling local user notifications \(error.localizedDescription)  :  \(error)")            }
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
    
}



class AlarmController: AlarmScheduler {

    
      static let shared = AlarmController()
    
    
    init() {
        loadFromPersistentStorage()
        self.alarms = self.mockAlarms
    }
    
  
   
    
  
    
    var alarms: [Alarm] = []
    
    var mockAlarms: [Alarm] = [
     
       
    
    Alarm(fireDate: Date(), name: "Alarm1"),
    Alarm(fireDate: Date(), name: "Alarm2"),
    Alarm(fireDate: Date(), name: "Alarm2")]
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let alarm = Alarm(fireDate: fireDate, name: name)
        
        AlarmController.shared.alarms.append(alarm)
        scheduleUserNotofications(for: alarm)
        saveToPersistentStorage()
    }
    //MARK: - update 
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {

        alarm.name = name
        alarm.fireDate = fireDate
        alarm.enabled = enabled
        scheduleUserNotofications(for: alarm)
        saveToPersistentStorage()
        
    }
    
    func delete(alarm: Alarm) {
        guard let index = AlarmController.shared.alarms.index(of: alarm) else {return}
        
        alarms.remove(at: index)
        scheduleUserNotofications(for: alarm)
        saveToPersistentStorage()
    }
    //step 6 
    func toggleEnabled(for alarm: Alarm){
       
        alarm.enabled = !alarm.enabled
       
        if alarm.enabled {
           scheduleUserNotofications(for: alarm)
        } else {
            scheduleUserNotofications(for: alarm)
        }
       
    }
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "Alarm.json"
        let documentDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentDirectoryURL
    }
    
    func saveToPersistentStorage() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(alarms)
            try data.write(to: fileURL())
        } catch {
            print(error)
        }
    }
    
    func loadFromPersistentStorage() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let alarms = try decoder.decode([Alarm].self, from: data)
            self.alarms = alarms
            
        } catch let error{
            print(error)
            
        }

    }

}

    
    
    

