//
//  LoanPaymentsSheduleView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 01.05.2025.
//

import SwiftUI

struct LoanPaymentsSheduleView: View {
    
    let loan: Loan
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.bgWhite.ignoresSafeArea()
            VStack(spacing: 16) {
                HeaderWithBackButton(title: "Payments Schedule", type: .dismiss)
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(loan.payments) { payment in
                            paymentCell(payment: payment)
                            if payment.id != loan.payments.last?.id {
                                Divider()
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
                    .background(.white, in: .rect(cornerRadius: 24))
                }
                .scrollIndicators(.never)
                .scrollBounceBehavior(.basedOnSize)
            }
            .safeAreaPadding(16)
        }
    }
    
    private func paymentCell(payment: Payment) -> some View {
        HStack{
            Text(payment.date.fullDate)
                .font(.poppins(.regular, size: 14))
                .foregroundStyle(.black.opacity(0.5))
            Spacer()
            Text(payment.amount.descriptionWithDolarSign)
                .font(.poppins(.bold, size: 17))
                .foregroundStyle(.black.opacity(payment.status == .future ? 0.5 : 1))
        }
    }
}

#Preview {
    LoanPaymentsSheduleView(loan: MockData.mockLoans[0])
}
