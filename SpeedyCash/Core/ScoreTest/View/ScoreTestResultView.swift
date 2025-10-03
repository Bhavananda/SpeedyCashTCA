//
//  ScoreTestResultView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 01.05.2025.
//

import SwiftUI

struct ScoreTestResultView: View {
    
    @Environment(\.dismiss) var dismiss
    let score: Double
    private let creditAdviceList: [AdviceModel] = [
        AdviceModel(number: "1", title: "Pay Bills On Time", description: "Always pay your credit cards, loans, and other bills by the due date to avoid late fees and negative marks on your credit report."),
        AdviceModel(number: "2", title: "Keep Balances Low", description: "Try to keep your credit card balances below 30% of the total limit to show responsible credit usage."),
        AdviceModel(number: "3", title: "Don’t Close Old Accounts", description: "Older accounts help build a longer credit history, which positively impacts your credit score."),
        AdviceModel(number: "4", title: "Limit New Credit Applications", description: "Too many hard inquiries in a short time can lower your score. Only apply for new credit when necessary."),
        AdviceModel(number: "5", title: "Check Credit Reports Regularly", description: "Review your credit reports for errors or fraud and dispute any inaccuracies with the credit bureau."),
        AdviceModel(number: "6", title: "Diversify Credit Types", description: "Having a mix of credit accounts—like credit cards, auto loans, and mortgages—can help improve your score."),
        AdviceModel(number: "7", title: "Increase Credit Limits", description: "Requesting a higher credit limit can improve your utilization rate, but only if you don’t increase your spending."),
        AdviceModel(number: "8", title: "Pay More Than Minimum", description: "Paying more than the minimum on credit cards helps reduce debt faster and shows stronger repayment behavior."),
        AdviceModel(number: "9", title: "Avoid Maxing Out Cards", description: "Using your full credit limit can hurt your score. Aim to use less than 30% of your available credit."),
        AdviceModel(number: "10", title: "Be Patient and Consistent", description: "Improving your credit score takes time. Focus on building good habits and be consistent with payments.")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                topSection
                testAdvices
            }
        }
        .bgWhiteWithBlur()
        .safeAreaPadding(.horizontal, 16)
        .safeAreaInset(edge: .bottom) {
            homeButton
        }
    }
}

#Preview {
    ScoreTestResultView(score: 450)
}

extension ScoreTestResultView {
    
    private var topSection: some View {
        VStack(spacing: 4) {
            Text("Result")
                .font(.poppins(.medium, size: 17))
            GaugeView(progress: score)
                .padding(.horizontal, 16)
            Text(score.intDescription)
                .font(.poppins(.bold, size: 28))
            HStack(spacing: 0) {
                Text("Your Score is ")
                    .font(.poppins(.regular, size: 14))
                    .foregroundStyle(.black.opacity(0.5))
                Text(getCreditScoreStatus(for: Int(score)))
                    .font(.poppins(.bold, size: 14))
            }
            Text(getCreditScoreDescription(for: Int(score)))
                .font(.poppins(.regular, size: 14))
                .foregroundStyle(.black.opacity(0.5))
                .multilineTextAlignment(.center)
        }
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
        .background(.white, in: .rect(cornerRadius: 24))
    }
    
    private var testAdvices: some View {
        VStack(spacing: 16) {
            HStack(spacing: 8) {
                Image(.test)
                Text("How Your Score Is Calculated")
                    .font(.poppins(.medium, size: 17))
                Spacer(minLength: 0)
            }
            ForEach(creditAdviceList) { advice in
                AdviceCell(advice: advice)
            }
        }
    }
    
    private var homeButton: some View {
        Button("Go Home") {
            dismiss()
        }
        .buttonStyle(.yellow)
        .safeAreaPadding(.horizontal, 16)
    }
    
    private func getCreditScoreDescription(for score: Int) -> String {
        let creditScoreExplanation = Questions.creditScoreExplanation
        
        for explanation in creditScoreExplanation {
            if explanation.range.contains(score) {
                return explanation.description
            }
        }
        
        return "Invalid score"
    }
    
    private func getCreditScoreStatus(for score: Int) -> String {
        return Questions.scoreStatus(for: score)
    }
}


fileprivate struct AdviceCell: View {
    @State var isOpened: Bool = false
    var advice: AdviceModel
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                Text(advice.number)
                    .font(.poppins(.bold, size: 17))
                    .frame(width: 44, height: 44)
                    .background(Color(hex: "EEEEEE"), in: .circle)
                Text(advice.title)
                Spacer()
                Image(isOpened ? .chevronUp : .chevronDown)
            }
            if isOpened {
                Text(advice.description)
                    .font(.poppins(.regular, size: 14))
                    .foregroundStyle(.black.opacity(0.5))
                    
            }
        }
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        .background(.white, in: .rect(cornerRadius: 24))
        .onTapGesture {
            withAnimation {
                isOpened.toggle()
            }
        }
        .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
        .animation(.default, value: isOpened)
    }
}


struct AdviceModel: Identifiable {
    let id: UUID = UUID()
    let number: String
    let title: String
    let description: String
}
