//
//  LoanRatingIndicator.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 29.04.2025.
//

import SwiftUI

struct LoanRatingIndicator: View {
    let rating: LoanRating
    var body: some View {
        Image(rating.icon)
            .frame(width: 58, height: 40)
            .background(Color(hex: rating.backgroundColorHex), in: .rect(cornerRadius: 44))
    }
}

#Preview {
    LoanRatingIndicator(rating: .average)
}
