//
//  Vibration+Notification.swift
//  Sport_app
//
//  Created by Bhavananda das on 29.08.2023.
//

import SwiftUI
import StoreKit
import UserNotifications
class Vibration{
    static let instance = Vibration()
    
    func simpleSuccess() {
        if UserDefaults.standard.bool(forKey: "Vibration"){
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        
    }

}
class NotificationClass{
    static let instance = NotificationClass()
    func showNotificationsSettings() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
            UIApplication.shared.open(appSettings)
        }
    }
}
class ReviewHandler {
    
    static func requestReview() {
        //DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        //}
    }
}
class NotificationManager{
    static func requestNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    static func disableNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    static func setNotifications(title: String, subTitle: String, date: Date, id: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subTitle
        content.sound = .default
        let dateComponents = Calendar.current.dateComponents([.minute, .hour, .day, .month, .year], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    static func removeSpecificNotifications(id: String) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [id])
    }
}
extension TimeInterval {
    private var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }

     var seconds: Int {
        return Int(self) % 60
    }

     var minutes: Int {
        return (Int(self) / 60 ) % 60
    }
    var hours: Int {
       return (Int(self) / 3600) % 24
   }
   var days: Int{
       return Int(self) / 86400
   }
    var stringTime: String {
        if hours != 0 {
            return "\(hours): \(minutes): \(seconds)"
        } else if minutes != 0 {
            return "\(minutes)m \(seconds)s"
        } else if milliseconds != 0 {
            return "\(seconds)s \(milliseconds)ms"
        } else {
            return "\(seconds)s"
        }
    }
}

struct CalendarRange {
    let calendar: Calendar
    let component: Calendar.Component
    let epoch: Date
    let values: ClosedRange<Int>
}
extension CalendarRange: Collection {
    typealias Index = ClosedRange<Int>.Index

    var startIndex: Index { self.values.startIndex }
    var endIndex: Index { self.values.endIndex }

    func index(after i: Index) -> Index { self.values.index(after: i) }

    subscript(index: Index) -> Date {
        self.calendar.date(
            byAdding: self.component,
            value: self.values[index],
            to: self.epoch
        )!
    }
}
extension CalendarRange: BidirectionalCollection {
    func index(before i: Index) -> Index { self.values.index(before: i) }
}
extension CalendarRange: RandomAccessCollection {}
extension Date {
    func substract(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: -minutes, to: self)!
    }
}
