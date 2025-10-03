//
//  EmptyStateView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 29.04.2025.
//

import SwiftUI

struct EmptyStateView: View {
    
    let type: EmptyType
    
    
    var body: some View {
        VStack(spacing: 8) {
            Image(.emptyStateIcon)
            VStack(spacing: 4) {
                Text(type.title)
                    .font(.poppins(.medium, size: 17))
                Text(type.subtitle)
                    .font(.poppins(.medium, size: 14))
                    .foregroundStyle(.black.opacity(0.5))
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView(type: .loans)
}

extension EmptyStateView {
    enum EmptyType {
        case calculation
        case loans
        case payments
        
        var title: String {
            switch self {
            case .calculation:
                "No Calculations Yet"
            case .loans:
                "No Loans Added"
            case .payments:
                "No payments yet"
            }
        }
        
        var subtitle: String {
            switch self {
            case .calculation:
                "Start by creating a loan calculation to explore your monthly payments and terms"
            case .loans:
                "Convert a saved calculation into a loan to begin tracking your payments and progress"
            case .payments:
                "Your payment history will appear here once you make your first payment"
            }
        }
    }
}
