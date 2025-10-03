//
//  PaymentSummaryView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 05.05.2025.
//

import SwiftUI

struct PaymentSummaryView: View {
    var paid: Double
    var leftToPay: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                Image(.paymentSummary)
                Text("Payment Summary")
                    .font(.poppins(.medium, size: 17))
                Spacer(minLength: 0)
            }
            HStack(spacing: 16) {
                chart
                VStack(alignment: .leading, spacing: 20) {
                    legendCell(colorHex: "FF880D", title: "Paid", value: paid.descriptionWithDolarSign)
                    legendCell(colorHex: "EEEEEE", title: "Left to Pay", value: leftToPay.descriptionWithDolarSign)
                }
            }
            .padding(EdgeInsets(top: 26, leading: 24, bottom: 26, trailing: 24))
            .background(.white, in: .rect(cornerRadius: 24))
        }
    }
}

#Preview {
    PaymentSummaryView(paid: 4000, leftToPay: 2000)
}

extension PaymentSummaryView {
    
    private var chart: some View {
        ZStack {
            Circle()
                .stroke(.black.opacity(0.03), lineWidth: 35)
            ZStack{
                Circle()
                    .stroke(Color(hex: "EEEEEE"), lineWidth: 23)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(LinearGradient(colors: [Color(hex: "FFC837"), Color(hex: "FF8008")], startPoint: .leading, endPoint: .trailing), style: .init(lineWidth: 23, lineCap: .round))
                    .rotationEffect(.degrees(270))
                VStack(spacing: 0) {
                    Text("Paid")
                        .font(.poppins(.regular, size: 14))
                        .foregroundStyle(.black.opacity(0.5))
                    Text(progressPercentage)
                        .font(.poppins(.bold, size: 17))
                }
            }
            .padding(12)
        }
        .padding(.horizontal, 12)
    }
    
    private func legendCell(colorHex: String, title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                Circle()
                    .fill(Color(hex: colorHex))
                    .frame(width: 8, height: 8)
                Text(title)
                    .font(.poppins(.regular, size: 14))
                Spacer(minLength: 0)
            }
            Text(value)
                .font(.poppins(.bold, size: 17))
                .padding(.leading, 12)
        }
    }
    
    
    private var totalValue: Double {
        paid + leftToPay
    }
    
    private var progressPercentage: String {
        let percent = Int(progress * 100)
        return percent.percentDescription
    }
    
    private var progress: CGFloat {
        let clampedPaid = max(paid, 0)
        guard totalValue > 0 else { return 0 }
        return CGFloat(clampedPaid) / CGFloat(totalValue)
    }
}
