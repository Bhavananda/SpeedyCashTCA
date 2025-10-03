//
//  CalculationCreatingResultView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 29.04.2025.
//

import SwiftUI

struct CalculationCreatingResultView: View {
    
    let calculation: Loan
    let isAlertVisible: Bool
    let onSaveTapped: () -> Void
    let onAlertOkayTapped: () -> Void
    let onGoHomeTapped: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Image(.calculationResultIcon)
                    .resizable()
                    .scaledToFit()
                ratingIndicator
                bottomSection
            }
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 34, trailing: 8))
            .background(.white, in: .rect(cornerRadius: 24))
        }
        .scrollIndicators(.never)
        .scrollBounceBehavior(.basedOnSize)
        .bgWhiteWithBlur()
        .safeAreaPadding(16)
        .safeAreaInset(edge: .bottom) {
            buttons
        }
        .overlay {
            if isAlertVisible {
                AppAlertView(type: .calculationSaved) {
                    onAlertOkayTapped()
                }
            }
        }
    }
    
    private var ratingIndicator: some View {
        VStack(spacing: 4) {
            LoanRatingIndicator(rating: calculation.rating)
            Text(calculation.rating.title)
                .font(.poppins(.bold, size: 22))
                .foregroundStyle(Color(hex: calculation.rating.foregroundColorHex))
        }
    }
    
    private var bottomSection: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom, spacing: 0) {
                infoCell(title: "Monthly", value: calculation.amount.monthlyPayment.descriptionWithDolarSign)
                    .foregroundStyle(.accentOrange)
                Divider()
                    .frame(height: 47)
                infoCell(title: "Total Amount ", value: calculation.amount.totalPayable.descriptionWithDolarSign)
            }
            Divider()
                .frame(width: 270)
            HStack(alignment: .top, spacing: 0) {
                infoCell(title: "Overpayment", value: calculation.amount.interestPaid.descriptionWithDolarSign)
                Divider()
                    .frame(height: 47)
                
                infoCell(title: "End Date", value: calculation.dates.endDate.fullDottedDate)
            }
        }
        .padding(EdgeInsets(top: 5.5, leading: 16, bottom: 5.5, trailing: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black.opacity(0.1), lineWidth: 1.0)
        }
    }
    
    private var buttons: some View {
        VStack(spacing: 16) {
            Button("Save Calculation") {
                onSaveTapped()
            }
            .buttonStyle(.yellow)
            Button {
                onGoHomeTapped()
                //dismiss()
            } label: {
                Text("Go Home")
                    .font(.poppins(.medium, size: 17))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
            }
            
        }
        .safeAreaPadding(.horizontal, 16)
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
        .padding(.vertical, 8)
    }
}

#Preview {
    CalculationCreatingResultView(calculation: MockData.mockLoans[0], isAlertVisible: false) {
        
    } onAlertOkayTapped: {
        
    } onGoHomeTapped: {
        
    }

}
