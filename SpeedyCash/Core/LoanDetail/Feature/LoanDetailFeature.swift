//
//  LoanDetailFeature.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 30.04.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct LoanDetailFeature {
    
    @ObservableState
    struct State: Equatable {
        var loan: Loan
        var showDeleteAlert: Bool = false
        var showCompleteAlert: Bool = false
        var showHistorySheet: Bool = false
        var showPaymentAlert: Bool = false
    }
    
    enum Action {
        case showHistorySheetTapped(Bool)
        case deleteTapped
        case deleteConfirmTapped
        case alertDimissed
        case payMonthlyTapped
        case completeTapped
        case showPaymentAlert(Bool)
    }
    
    @Dependency(\.dataService) var dataService
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .showHistorySheetTapped(let isPresented):
                state.showHistorySheet = isPresented
                return .none
            case .deleteTapped:
                state.showDeleteAlert = true
                return .none
            case .deleteConfirmTapped:
                state.showDeleteAlert = false
                dataService.deleteLoan(state.loan)
                //await self.dismiss()
                return .none
            case .alertDimissed:
                state.showDeleteAlert = false
                return .none
            case .payMonthlyTapped:
                state.loan.addMonthlyPayment()
                state.showPaymentAlert = true
                dataService.addOrUpdateLoan(state.loan)
                return .none
            case let .showPaymentAlert(result):
                state.showPaymentAlert = result
                return .none
            case .completeTapped:
                state.loan.completeLoan()
                dataService.addOrUpdateLoan(state.loan)
                state.showCompleteAlert = true
                return .none
            }
        }
    }
}
