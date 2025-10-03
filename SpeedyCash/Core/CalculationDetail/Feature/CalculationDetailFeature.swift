//
//  CalculationDetailFeature.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 30.04.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CalculationDetailFeature {
    
    @ObservableState
    struct State: Equatable {
        var calculation: Loan
        var loanName: String = ""
        var loanIcon: String = ""
        var showDeleteAlert: Bool = false
        var showAddLoan: Bool = false
        var showSavedAlert: Bool = false
        
        var isSaveDisable: Bool {
            loanName.isEmpty || loanIcon.isEmpty
        }
    }
    
    
    @CasePathable
    enum Action {
        case addToLoanTapped
        case showAddLoanSheet(Bool)
        case deleteTapped
        case deleteConfirmTapped
        case nameChanged(String)
        case iconChanged(String)
        case alertDismissed
        case loanSavedSuccessfully
        case savedAlertDismissed
        case saveLoanTapped
    }
    
    @Dependency(\.dataService) var dataService
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addToLoanTapped:
                state.showAddLoan = true
                return .none
            case let .showAddLoanSheet(result):
                state.showAddLoan = result
                return .none
            case .deleteTapped:
                state.showDeleteAlert = true
                return .none
            case .deleteConfirmTapped:
                state.showDeleteAlert = false
                dataService.deleteCalculation(state.calculation)
                return .none
            case .nameChanged(let name):
                state.loanName = name
                return .none
            case .iconChanged(let icon):
                state.loanIcon = icon
                return .none
            case .alertDismissed:
                state.showDeleteAlert = false
                return .none
            case .loanSavedSuccessfully:
                state.showSavedAlert = true
                return .none
            case .savedAlertDismissed:
                state.showSavedAlert = false
                return .none
            case .saveLoanTapped:
                let loan = Loan(
                    id: state.calculation.id,
                    name: state.loanName,
                    icon: state.loanIcon,
                    amount: state.calculation.amount,
                    dates: state.calculation.dates,
                    payments: state.calculation.payments,
                    rating: state.calculation.rating
                )
                dataService.moveCalculationToLoan(loan)

                return .none
            }
        }
    }
}
