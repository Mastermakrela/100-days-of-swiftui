//
//  UserNotificationsDemo.swift
//  HotProspects
//
//  Created by Krzysztof Kostrzewa on 06.04.21.
//

import SwiftUI
import UserNotifications

struct UserNotificationsDemo: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }

            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = .default

                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct UserNotificationsDemo_Previews: PreviewProvider {
    static var previews: some View {
        UserNotificationsDemo()
    }
}
