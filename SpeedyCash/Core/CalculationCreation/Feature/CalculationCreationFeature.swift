//
//  CalculationCreationFeature.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 29.04.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct  CalculationCreationFeature {
    
    @ObservableState
    struct State: Equatable {
        var amount: Double = 0
        var interestRate: Double = 0
        var term: Int = 0
        var resultCalculation: Loan?
        var isAlertVisible: Bool = false
        var shouldDismissResult: Bool = false
        
        var isGetResultButtonDisnabled: Bool {
            amount == 0 || term == 0
        }
    }
    
    enum Action {
        case amountChanged(Double)
        case interestRateChanged(Double)
        case termChanged(Int)
        case getResultTapped
        case resultSheetChanged(Loan?)
        case saveTapped
        case alertOkayTapped
        case goHomeTapped
    }
    
    @Dependency(\.dataService) var dataService
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .amountChanged(value):
                state.amount = value
                return .none

            case let .interestRateChanged(value):
                state.interestRate = value
                return .none

            case let .termChanged(value):
                state.term = value
                return .none

            case .getResultTapped:
                state.resultCalculation = createCredit(state: state)
                return .none

            case let .resultSheetChanged(value):
                state.resultCalculation = value
                state.isAlertVisible = false
                state.shouldDismissResult = false
                return .none

            case .saveTapped:
                dataService.addCalculation(createCredit(state: state))
                state.isAlertVisible = true
                return .none

            case .alertOkayTapped:
                state.resultCalculation = nil // ховає fullScreenCover
                state.isAlertVisible = false
                return .none

            case .goHomeTapped:
                state.resultCalculation = nil
                return .none
            }
        }
    }
    
    private func createCredit(state: State) -> Loan {
        let amount = LoanAmount(
            principal: state.amount,
            interestRate: state.interestRate,
            termInMonths: state.term,
            downPayment: 0
        )
        let dates = LoanDates(
            startDate: Date(),
            termInMonths: state.term
        )
        let payments = LoanCalculator.generatePayments(
            startDate: dates.startDate,
            term: state.term,
            monthlyPayment: amount.monthlyPayment
        )
        let rating = LoanCalculator.calculateLoanRating(interestRate: state.interestRate)
        return Loan(amount: amount, dates: dates, payments: payments, rating: rating)
    }
}
