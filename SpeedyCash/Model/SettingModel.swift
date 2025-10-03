//
//  SettingModel.swift
//  DayApp
//
//  Created by Bhavananda das on 21.12.2023.
//

import SwiftUI

struct SettingModel: Identifiable, Equatable {
    let id: UUID
    let iconName: ImageResource
    let name: String
    let type: SettingsCellType
    let isSwither: Bool

    init(iconName: ImageResource, name: String, type: SettingsCellType, isSwither: Bool = false) {
        self.id = UUID()
        self.iconName = iconName
        self.name = name
        self.type = type
        self.isSwither = isSwither
    }
}


enum SettingsCellType {
    case notification
    case currency
    case score
    case analytics
    case rateUs
    case feedback
    case terms
    case policy
}
