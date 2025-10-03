//
//  CalculationDetailView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 30.04.2025.
//

import SwiftUI
import ComposableArchitecture

struct CalculationDetailView: View {
    
    @Bindable var store: StoreOf<CalculationDetailFeature>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            VStack(spacing: 16) {
                HeaderWithBackButton(title: "Calculation Details")
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
            }
            .navigationBarBackButtonHidden()
            .bgWhiteWithBlur()
            .safeAreaPadding(16)
            .safeAreaInset(edge: .bottom) {
                buttons
            }
            .sheet(isPresented: $store.showAddLoan.sending(\.showAddLoanSheet), content: {
                AddToLoanView(
                    loanName: $store.loanName.sending(\.nameChanged),
                    loanIcon: $store.loanIcon.sending(\.iconChanged),
                    isPresented: $store.showAddLoan.sending(\.showAddLoanSheet),
                    onSave: {
                        store.send(.saveLoanTapped)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            dismiss()
                        }
                    }
                )
            })
            .alert(
                "Delete Calculation",
                isPresented: viewStore.binding(
                    get: \.showDeleteAlert,
                    send: .alertDismissed
                ),
                actions: {
                    Button("Delete", role: .destructive) {
                        viewStore.send(.deleteConfirmTapped)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            dismiss()
                        }
                    }
                    Button("Cancel", role: .cancel) { }
                },
                message: {
                    Text("Are you sure you want to delete this calculation? This action cannot be undone.")
                }
            )
        }
    }
}

#Preview {
    CalculationDetailView(store: Store(initialState: CalculationDetailFeature.State(calculation: MockData.mockLoans[0]), reducer: {
        CalculationDetailFeature()
    }))
}

extension CalculationDetailView {
    private var ratingIndicator: some View {
        VStack(spacing: 4) {
            LoanRatingIndicator(rating: store.calculation.rating)
            Text(store.calculation.rating.title)
                .font(.poppins(.bold, size: 22))
                .foregroundStyle(Color(hex: store.calculation.rating.foregroundColorHex))
        }
    }
    
    private var bottomSection: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom, spacing: 0) {
                infoCell(title: "Monthly", value: store.calculation.amount.monthlyPayment.descriptionWithDolarSign)
                    .foregroundStyle(.accentOrange)
                Divider()
                    .frame(height: 47)
                infoCell(title: "Total Amount ", value: store.calculation.amount.totalPayable.descriptionWithDolarSign)
            }
            Divider()
                .frame(width: 270)
            HStack(alignment: .top, spacing: 0) {
                infoCell(title: "Overpayment", value: store.calculation.amount.interestPaid.descriptionWithDolarSign)
                Divider()
                    .frame(height: 47)
                
                infoCell(title: "End Date", value: store.calculation.dates.endDate.fullDottedDate)
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
            Button("Add to Loans") {
                store.send(.addToLoanTapped)
            }
            .buttonStyle(.yellow)
            Button {
                store.send(.deleteTapped)
            } label: {
                Text("Delete")
                    .font(.poppins(.medium, size: 17))
                    .foregroundStyle(.red)
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
