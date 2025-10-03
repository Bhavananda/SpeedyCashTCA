//
//  CalculationCell.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 29.04.2025.
//

import SwiftUI

struct CalculationCell: View {
    
    let calculation: Loan
    
    
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 4) {
                topSection
                middleSection
                bottomSection
            }
        }
        .padding(16)
        .background(.white, in: .rect(cornerRadius: 24))
    }
}

#Preview {
    CalculationCell(calculation: MockData.mockLoans[0])
}

extension CalculationCell {
    
    private var topSection: some View {
        HStack {
            Text(calculation.rating.title)
                .font(.poppins(.medium, size: 17))
                .foregroundStyle(Color(hex: calculation.rating.foregroundColorHex))
            Spacer()
            LoanRatingIndicator(rating: calculation.rating)
        }
    }
    
    private var middleSection: some View {
        HStack(spacing: 0) {
            Text("Monthly ")
                .font(.poppins(size: 14))
                .foregroundStyle(.black.opacity(0.5))
            Text(calculation.amount.monthlyPayment.descriptionWithDolarSign)
                .font(.poppins(.bold, size: 17))
        }
    }
    
    private var bottomSection: some View {
        HStack(spacing: 4) {
            infoCell(title: "Rate", value: calculation.amount.interestRate.intPercentDescription)
            Divider()
                .frame(height: 33)
            infoCell(title: "Term", value: calculation.amount.termInMonths.description + "mo.")
        }
        .padding(EdgeInsets(top: 5.5, leading: 16, bottom: 5.5, trailing: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black.opacity(0.1), lineWidth: 1.0)
        }
        .padding(.horizontal, 24)
    }
    
    private func infoCell(title: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.poppins(.regular, size: 14))
                .foregroundStyle(.black.opacity(0.5))
            Text(value)
                .font(.poppins(.bold, size: 17))
        }
        .frame(maxWidth: .infinity)
    }
}
