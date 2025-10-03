//
//  AppDelegate.swift
//  NewStrategy
//
//  Created by Bhavananda das on 19.02.2024.
//

import Foundation
import UIKit
//import OneSignalFramework
import FirebaseCore
//import AppTrackingTransparency
//import AdSupport

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // MARK: Firebase
//        FirebaseApp.configure()
        // MARK: OneSignal

//        OneSignal.initialize("", withLaunchOptions: launchOptions)
//        OneSignal.Notifications.requestPermission({ accepted in
//            print("User accepted notifications: \(accepted)")}, fallbackToSettings: true)
        return true
    }
}
