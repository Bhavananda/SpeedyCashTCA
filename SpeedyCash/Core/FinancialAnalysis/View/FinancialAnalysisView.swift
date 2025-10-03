//
//  FinancialAnalysisView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 05.05.2025.
//

import SwiftUI
import ComposableArchitecture

struct FinancialAnalysisView: View {
    
    @Bindable var store: StoreOf<FinancialAnalyticsFeature>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 16) {
                HeaderWithBackButton(title: "Financial Analysis")
                ScrollView {
                    VStack(spacing: 24) {
                        banner
                        pages
                    }
                }
                .scrollIndicators(.never)
                .scrollBounceBehavior(.basedOnSize)
            }
            .safeAreaPadding(.horizontal, 16)
            .navigationBarBackButtonHidden()
            .foregroundStyle(.black)
            .hideKeyboardOnTap()
            .bgWhiteWithBlur()
            .safeAreaInset(edge: .bottom) {
                nextButton
            }
            .overlay {
                if store.showFinishAlert {
                    AppAlertView(type: .requestSend) {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    FinancialAnalysisView(store: Store(initialState: FinancialAnalyticsFeature.State(), reducer: {
        FinancialAnalyticsFeature()
    }))
}

extension FinancialAnalysisView {
    
    private var banner: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Boost Your Finances")
                    .font(.poppins(.bold, size: 17))
                Text("Fill out a quick form to see how you can boost your financial situation.")
                    .font(.poppins(.regular, size: 14))
                    .foregroundStyle(.black.opacity(0.5))
            }
            Spacer(minLength: 0)
            Image(.dollarIcon)
            
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .background(.white, in: .rect(cornerRadius: 24))
    }
    
    private var pages: some View {
        Group{
            switch store.currentPage {
            case .first: firstPage
            case .second: secondPage
            }
        }
        .animation(.easeIn(duration: 0.5), value: store.currentPage)
    }
    
    private var firstPage: some View {
        VStack(spacing: 24) {
            AnalysisField(
                text: $store.loanAmount.sending(\.loanAmountChanged),
                isValid: $store.amountIsValid.sending(\.amountValidationResultChanged),
                type: .amount
            )
            .keyboardType(.numberPad)
            AnalysisField(
                text: $store.tin.sending(\.tinChanged),
                isValid: $store.tinIsValid.sending(\.tinValidationResultChanged),
                type: .tin
            )
            .keyboardType(.numberPad)
            AnalysisField(
                text: $store.dateOfBirth.sending(\.dateOfBirthChanged),
                isValid: $store.dateOfBirthIsValid.sending(\.dateOfBirthValidationResultChanged),
                type: .birth
            )
            .keyboardType(.numberPad)
            
        }
        .tag(CreationPage.first)
        .transition(.slideForward)
    }
    
    private var secondPage: some View {
        VStack(spacing: 24) {
            AnalysisField(
                text: $store.email.sending(\.emailChanged),
                isValid: $store.emailIsValid.sending(\.emailValidationResultChanged),
                type: .email
            )
            AnalysisField(
                text: $store.phoneNumber.sending(\.phoneNumberChanged),
                isValid: $store.phoneNumberIsValid.sending(\.phoneNumberValidationResultChanged),
                type: .phoneNumber
            )
            .keyboardType(.numberPad)
        }
        .tag(CreationPage.second)
        .transition(.slideForward)
    }
    
    private var nextButton: some View {
        Button(nextButtonTitle) {
            store.send(.nextPageTapped)
        }
        .buttonStyle(.yellow)
        .disabled(isNextButtonDisabled)
        .safeAreaPadding(16)
    }
    
    private var nextButtonTitle: String {
        switch store.currentPage {
        case .first: "Next"
        case .second: "Get Result"
        }
    }
    
    private var isNextButtonDisabled: Bool {
        switch store.currentPage {
        case .first: store.isNextDisable
        case .second: store.isGetResultDisable
        }
    }
}
