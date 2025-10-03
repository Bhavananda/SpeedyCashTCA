//
//  LoanCell.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 29.04.2025.
//

import SwiftUI

struct LoanCell: View {
    
    let loan: Loan
    
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 4) {
                topSection
                middleSection
            }
            LoanProgressView(loan: loan)
        }
        .padding(16)
        .background(.white, in: .rect(cornerRadius: 24))
    }
}

#Preview {
    LoanCell(loan: MockData.mockLoans[0])
}

extension LoanCell {
    private var topSection: some View {
        HStack {
            Image(loan.icon)
            Text(loan.name)
                .font(.poppins(.medium, size: 17))
            Spacer()
            LoanRatingIndicator(rating: loan.rating)
        }
    }
    
    private var middleSection: some View {
        HStack(spacing: 0) {
            Text("Monthly ")
                .font(.poppins(size: 14))
                .foregroundStyle(.black.opacity(0.5))
            Text(loan.amount.monthlyPayment.descriptionWithDolarSign)
                .font(.poppins(.bold, size: 17))
        }
    }
}
