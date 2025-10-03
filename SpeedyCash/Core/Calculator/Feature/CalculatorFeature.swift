//
//  CalculatorFeature.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 29.04.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct  CalculatorFeature {
    
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
        
        var loans: [Loan] = []
        var calculations: [Loan] = []
        var selectedPage: LoanType = .calculation
    }
    
    enum Action {
        case onAppear
        case loansUpdated([Loan])
        case calculationUpdated([Loan])
        case selectedPageChanged(LoanType)
        case newCalculationTapped
        case loanTapped(Loan)
        case calculationTapped(Loan)
        
        case destination(PresentationAction<Destination.Action>)
    }
    
    enum CancelID {
        case calculationsSubscription
        case loansSubscription
    }
    
    
    @Dependency(\.dataService) var dataService
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                let loansEffect = Effect.publisher {
                    dataService.loansPublisher()
                        .map { loans in
                            return CalculatorFeature.Action.loansUpdated(loans)
                        }
                }
                    .cancellable(id: CancelID.loansSubscription, cancelInFlight: true)
                let calculationsEffect = Effect.publisher {
                    dataService.calculationsPublisher()
                        .map { loans in
                            return CalculatorFeature.Action.calculationUpdated(loans)
                        }
                }
                    .cancellable(id: CancelID.calculationsSubscription, cancelInFlight: true)
                return .merge(calculationsEffect, loansEffect)
            case let .loansUpdated(loans):
                state.loans = loans
                return .none
            case let .calculationUpdated(loans):
                state.calculations = loans
                return .none
            case let .selectedPageChanged(page):
                state.selectedPage = page
                return .none
            case .newCalculationTapped:
                state.destination = .creation(CalculationCreationFeature.State())
                return .none
            case let .loanTapped(loan):
                state.destination = .loanDetail(LoanDetailFeature.State(loan: loan))
                return .none
            case let .calculationTapped(loan):
                state.destination = .calculationDetail(CalculationDetailFeature.State(calculation: loan))
                return .none
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension CalculatorFeature {
    @Reducer(state: .equatable)
    enum Destination {
        case creation(CalculationCreationFeature)
        case loanDetail(LoanDetailFeature)
        case calculationDetail(CalculationDetailFeature)
    }
}
