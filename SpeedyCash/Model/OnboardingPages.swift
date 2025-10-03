//
//  OnboardingPages.swift
//  ToDay
//
//  Created by Bhavananda das on 16.04.2025.
//

import SwiftUI

enum OnboardingPages: Equatable {
    case first
    case second
    case third
    
}


struct OnboardingModel: Identifiable, Equatable {
    var id: UUID = UUID()
    var image: ImageResource
    var title: String
    var subtitle: String
    var page: OnboardingPages
}
