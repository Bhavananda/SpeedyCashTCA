//
//  SpeedyCashApp.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 25.04.2025.
//

import SwiftUI
import ComposableArchitecture

@main
struct SpeedyCashApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            PreloaderScreen(store: Store(initialState: PreloaderFeature.State(), reducer: {
                PreloaderFeature()
            }))
        }
    }
}
