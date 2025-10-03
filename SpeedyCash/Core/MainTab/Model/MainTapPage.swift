//
//  MainTapPage.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 31.10.2024.
//

import SwiftUI


enum MainTapPage: String, Identifiable, CaseIterable, Hashable{
    case home
    case offers
    case calculator
    case settings
    
    var id: String{
        UUID().uuidString
    }
    
    var title: String {
        switch self {
        case .home: "Home"
        case .offers: "Offers"
        case .calculator: "Calculator"
        case .settings: "Settings"
        }
    }
    
    var icon: ImageResource {
        switch self {
        case .home:
                .tabHome
        case .offers:
                .tabOffers
        case .calculator:
                .tabCalculator
        case .settings:
                .tabSettings
        }
    }
}
