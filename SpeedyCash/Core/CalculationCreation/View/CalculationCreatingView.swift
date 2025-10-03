//
//  CalculationCreatedView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 29.04.2025.
//

import SwiftUI
import ComposableArchitecture

struct CalculationCreatingView: View {
    
    @Bindable var store: StoreOf<CalculationCreationFeature>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 16) {
                HeaderWithBackButton(title: "New Calculation")
                CalculationCreationSlider(
                    calculationStyle: .amount,
                    value: $store.amount.sending(\.amountChanged)
                )
                CalculationCreationSlider(
                    calculationStyle: .interest,
                    value: $store.interestRate.sending(\.interestRateChanged)
                )
                termTextField
            }
            .safeAreaPadding(.horizontal, 16)
            .bgWhiteWithBlur()
            .navigationBarBackButtonHidden(true)
            .foregroundStyle(Color.black)
            .safeAreaInset(edge: .bottom) {
                getResultButton
            }
            .fullScreenCover(item: $store.resultCalculation.sending(\.resultSheetChanged)) { loan in
                CalculationCreatingResultView(
                    calculation: loan,
                    isAlertVisible: store.isAlertVisible,
                    onSaveTapped: {
                        store.send(.saveTapped)
                    },
                    onAlertOkayTapped: {
                        store.send(.alertOkayTapped)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            dismiss()
                        }
                    },
                    onGoHomeTapped: {
                        store.send(.goHomeTapped)
                    }
                )
            }
        }
    }
}

#Preview {
    CalculationCreatingView(store: Store(initialState: CalculationCreationFeature.State(), reducer: {
        CalculationCreationFeature()
    }))
}

extension CalculationCreatingView {
    private var termTextField: some View {
        VStack(spacing: 4) {
            Text("Term (in month)")
                .font(.poppins(.medium, size: 17))
            TextField(
                value: $store.term.sending(\.termChanged),
                format: .number) {
                    Text(store.term.description)
                        .font(.poppins(size: 17))
                    
                }
                .keyboardType(.numberPad)
                .padding(EdgeInsets(top: 9, leading: 16, bottom: 9, trailing: 16))
                .background(.white, in: .rect(cornerRadius: 24))
        }
    }
    
    private var getResultButton: some View {
        Button("Get Result") {
            store.send(.getResultTapped)
        }
        .buttonStyle(.yellow)
        .safeAreaPadding(16)
        .disabled(store.isGetResultButtonDisnabled)
    }
}
