//
//  CreationPage.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 12.03.2025.
//

import Foundation

enum CreationPage: Int, CaseIterable, Identifiable {
    case first = 1
    case second
    
    var id: String {
        UUID().uuidString
    }
}
