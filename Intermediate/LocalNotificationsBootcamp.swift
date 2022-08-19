//
//  LocalNotificationsBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 7/24/22.
//

import SwiftUI
import UserNotifications
import CoreLocation

class LocalNotificationsManager{
    static let instance = LocalNotificationsManager()
    
    func requestAuthorization(){
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) {
            (success, error) in
            if let error = error {
                print("error=> \(error.localizedDescription)")
            } else {
                print("success")
            }
        }
    }
    
    func schedualNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Hey"
        content.subtitle = "this is subtitle"
        content.badge = 1
        content.sound = .default
        content.body = "this is me"
        content.launchImageName = "prfl"
        
        //Time
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        var date = DateComponents()
        date.hour = 17
        date.minute = 7
        let dateTrigger = UNCalendarNotificationTrigger(
            dateMatching: date,
            repeats: true)
        
        //Location
        let cordinate = CLLocationCoordinate2D(latitude: 20.40, longitude: 3.50)
        let region = CLCircularRegion(
            center: cordinate,
            radius: 100,
            identifier: UUID().uuidString
        )
        region.notifyOnExit = true
        region.notifyOnEntry = true
        var regionTrigger = UNLocationNotificationTrigger(
            region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
        print("added")
    }


    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}

struct LocalNotificationsBootcamp: View {
    var body: some View {
        VStack{
            Button("Request") {
                LocalNotificationsManager.instance.requestAuthorization()
            }
            
            Button("Schedual notification") {
                LocalNotificationsManager.instance.schedualNotification()
            }
            
            Button("cancel schedualed notification") {
                LocalNotificationsManager.instance.cancelNotification()
            }
        }
        .onAppear(perform: {
            UIApplication.shared.applicationIconBadgeNumber = 0
        })
    }
}

struct LocalNotificationsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationsBootcamp()
    }
}
