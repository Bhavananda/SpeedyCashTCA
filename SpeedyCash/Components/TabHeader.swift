//
//  TabHeader.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 28.04.2025.
//

import SwiftUI

struct TabHeader: View {
    
    var page: MainTapPage
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.poppins(.medium, size: 34))
            Text(subtitle)
                .font(.poppins(.regular, size: 14))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TabHeader(page: .calculator)
}

extension TabHeader {
    var title: String {
        switch page {
        case .home: "Welcome Back!"
        case .offers: "Offers"
        case .calculator: "Calculator"
        case .settings: "Settings"
        }
    }
    
    var subtitle: String {
        switch page {
        case .home: "Track & analyze"
        case .offers: "Explore, compare, and choose the right offer"
        case .calculator: "Start by creating a loan calculation"
        case .settings: "Manage your app preferences"
        }
    }
}
