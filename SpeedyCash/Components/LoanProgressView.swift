//
//  LoanProgressView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 29.04.2025.
//

import SwiftUI

struct LoanProgressView: View {
    
    var loan: Loan
    private let progressGradiend = LinearGradient(
        colors: [Color(hex: "FD8732"), Color(hex: "ECD945"), Color(hex: "78EC53"), Color(hex: "44EFA7")],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    var body: some View {
        VStack(spacing: 8) {
            progressView
            switch loan.state {
            case .active:
                leftToPay
            case .completed:
                closedIndicator
            }
        }
    }
    
    private var progressView: some View {
        GeometryReader { geo in
            let width = geo.size.width * loan.progress
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 44)
                    .fill(.black.opacity(0.1))
                progressGradiend
                    .mask {
                        RoundedRectangle(cornerRadius: 44)
                            .frame(width: width)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .animation(.default, value: loan.progress)
            }
        }
        .frame(height: 8)
    }
    
    private var leftToPay: some View {
        HStack {
            Text("Left to pay")
                .font(.poppins(size: 14))
                .foregroundStyle(.black.opacity(0.5))
            Spacer()
            Text(loan.amount.monthlyPayment.descriptionWithDolarSign)
                .font(.poppins(.bold, size: 14))
                .foregroundStyle(.accentOrange)
        }
    }
    
    private var closedIndicator: some View {
        Text("Loan Closed")
            .font(.poppins(size: 14))
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    LoanProgressView(loan: MockData.mockLoans[0])
}
