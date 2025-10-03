//
//  AppAlertView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 05.05.2025.
//

import SwiftUI

struct AppAlertView: View {
    
    var type: AlertType
    var okayTapped: () -> ()
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6).ignoresSafeArea()
            VStack(spacing: 12) {
                VStack(spacing: 4) {
                    Text(type.title)
                        .font(.poppins(.medium, size: 22))
                    Text(type.subtitle)
                        .font(.poppins(size: 14))
                        .foregroundStyle(.black.opacity(0.5))
                        .multilineTextAlignment(.center)
                }
                Button("Okay") {
                    okayTapped()
                }
                .buttonStyle(.yellow)
            }
            .frame(width: 189)
            .padding(22)
            .background(.white, in: .rect(cornerRadius: 28))
        }
    }
}

#Preview {
    AppAlertView(type: .calculationSaved){}
}

extension AppAlertView {
    
    enum AlertType {
        case calculationSaved
        case savedToLoan
        case paidSuccesfull
        case loanClosed
        case requestSend
        
        var title: String {
            switch self {
            case .calculationSaved:
                "Saved!"
            case .savedToLoan:
                "Saved!"
            case .paidSuccesfull:
                "Successful!"
            case .loanClosed:
                "Loan Сlosed!"
            case .requestSend:
                "Request sent!"
            }
        }
        
        var subtitle: String {
            switch self {
            case .calculationSaved:
                "You can view it anytime in your saved calculations"
            case .savedToLoan:
                "Your loan has been successfully added"
            case .paidSuccesfull:
                "You’ve paid monthly loan bill"
            case .loanClosed:
                "You’ve paid off this loan completely"
            case .requestSend:
                "We’ll review it and email the results."
            }
        }
    }
}
