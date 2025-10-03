//
//  LoanDetailView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 30.04.2025.
//

import SwiftUI
import ComposableArchitecture

struct LoanDetailView: View {
    
    @Bindable var store: StoreOf<LoanDetailFeature>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            VStack(spacing: 16) {
                HeaderWithBackButton(title: "Loan Details") {
                    deleteButton
                }
                ScrollView {
                    VStack(spacing: 24) {
                        topSection
                        if viewStore.loan.payments.isEmpty {
                            EmptyStateView(type: .payments)
                        } else {
                            paymentsSection
                        }
                    }
                }
                .scrollIndicators(.never)
                .scrollBounceBehavior(.basedOnSize)
            }
            .navigationBarBackButtonHidden()
            .foregroundStyle(.black)
            .safeAreaPadding(.horizontal, 16)
            .bgWhiteWithBlur()
            
            .safeAreaInset(edge: .bottom, content: {
                if viewStore.loan.state == .active {
                    bottomButtons
                }
            })
            .overlay(content: {
                if viewStore.showPaymentAlert {
                    AppAlertView(type: .paidSuccesfull) {
                        store.send(.showPaymentAlert(false))
                    }
                }
                if viewStore.showCompleteAlert {
                    AppAlertView(type: .loanClosed) {
                        dismiss()
                    }
                }
            })
            .alert("Delete Loan", isPresented:  viewStore.binding(
                get: \.showDeleteAlert,
                send: .alertDimissed
            )) {
                Button("Delete", role: .destructive) {
                    viewStore.send(.deleteConfirmTapped)
                    dismiss()
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Are you sure you want to delete this calculation? This action cannot be undone.")
            }
            .sheet(isPresented: $store.showHistorySheet.sending(\.showHistorySheetTapped)) {
                LoanPaymentsSheduleView(loan: viewStore.loan)
            }
        }
    }
}

#Preview {
    LoanDetailView(store: Store(initialState: LoanDetailFeature.State(loan: MockData.mockLoans[0]), reducer: {
        LoanDetailFeature()
    }))
}


extension LoanDetailView {
    private var deleteButton: some View {
        Button {
            store.send(.deleteTapped)
        } label: {
            Image(.trash)
        }
    }
    
    private var topSection: some View {
        VStack(spacing: 24) {
            HStack(spacing: 12) {
                Image(store.loan.icon)
                Text(store.loan.name)
                    .font(.poppins(.medium, size: 17))
                Spacer()
                LoanRatingIndicator(rating: store.loan.rating)
            }
            loanInfoView
            LoanProgressView(loan: store.loan)
        }
        .padding(EdgeInsets(top: 22, leading: 16, bottom: 22, trailing: 16))
        .background(.white, in: .rect(cornerRadius: 24))
    }
    
    private var loanInfoView: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom, spacing: 0) {
                infoCell(title: "Monthly", value: store.loan.amount.monthlyPayment.descriptionWithDolarSign)
                    .foregroundStyle(.accentOrange)
                Divider()
                    .frame(height: 47)
                infoCell(title: "Total Amount ", value: store.loan.amount.totalPayable.descriptionWithDolarSign)
            }
            Divider()
                .frame(width: 270)
            HStack(alignment: .top, spacing: 0) {
                infoCell(title: "Overpayment", value: store.loan.amount.interestPaid.descriptionWithDolarSign)
                Divider()
                    .frame(height: 47)
                infoCell(title: "End Date", value: store.loan.dates.endDate.fullDottedDate)
            }
        }
        .padding(EdgeInsets(top: 5.5, leading: 16, bottom: 5.5, trailing: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black.opacity(0.1), lineWidth: 1.0)
        }
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
    
    private var paymentsSection: some View {
        VStack(spacing: 16) {
            HStack(spacing: 4) {
                Image(.normalOffers)
                Text("Recent Payments")
                    .font(.poppins(.medium, size: 17))
                Spacer(minLength: 0)
                Button {
                    store.send(.showHistorySheetTapped(true))
                } label: {
                    Text("View All")
                        .font(.poppins(.medium, size: 14))
                }

            }
            VStack(spacing: 8) {
                ForEach(paymentsArray) { payment in
                    paymentCell(payment: payment)
                    if payment.id != store.loan.payments.prefix(3).last?.id {
                        Divider()
                    }
                }
            }
            .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
            .background(.white, in: .rect(cornerRadius: 24))
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
                .foregroundStyle( Color.black.opacity(payment.status == .future ? 0.5 : 1.0))
        }
    }
    
    private var bottomButtons: some View {
        VStack(spacing: 16) {
            Button("Pay Monthly Payment ") {
                store.send(.payMonthlyTapped)
            }
            .buttonStyle(.yellow)
            Button {
                store.send(.completeTapped)
            } label: {
                Text("Complete Loan")
                    .font(.poppins(.medium, size: 17))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
            }

        }
        .safeAreaPadding(.horizontal, 16)
    }
    
    private var paymentsArray: [Payment] {
        switch store.loan.state {
        case .active: Array(store.loan.payments.filter({$0.status == .future}).prefix(3))
        case .completed: store.loan.payments.suffix(3)
        }
    }
}
