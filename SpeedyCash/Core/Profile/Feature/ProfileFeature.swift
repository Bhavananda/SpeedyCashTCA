//
//  ProfileFeature.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 05.05.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct  ProfileFeature {
    
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
        
        var testScore: Double = 0
        var paid: Double = 5000
        var leftToPay: Double = 10000
        var loans: [Loan] = []
    }
    
    enum Action {
        case task
        case testResponse(Double)
        case loadTestScore
        case loansResponse([Loan])
        case testTapped
        case analysisTapped
        case destination(PresentationAction<Destination.Action>)
    }
    
    enum CancelID {
        case testScoreSubscription
        case loansSubscription
    }
    
    @Dependency(\.dataService) var dataService
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .task:
                let testEffect = Effect.publisher {
                    dataService.testPublisher()
                        .map { testScore in
                            return ProfileFeature.Action.testResponse(testScore)
                        }
                }
                    .cancellable(id: CancelID.testScoreSubscription, cancelInFlight: true)
                
                let loansEffect = Effect.publisher {
                    dataService.loansPublisher()
                        .map { loans in
                            return ProfileFeature.Action.loansResponse(loans)
                        }
                }
                    .cancellable(id: CancelID.loansSubscription, cancelInFlight: true)
                
                return .merge(testEffect, loansEffect)
                
            case .testResponse(let value):
                state.testScore = value
                return .none
                
            case .loansResponse(let loans):
                state.loans = loans
                state.paid = loans.reduce(0, {$0 + $1.amount.totalPaid})
                state.leftToPay = loans.reduce(0, {$0 + $1.remainingAmount})
                return .none
                
            case .testTapped:
                state.destination = .test(ScoreTestFeature.State())
                return .none
            case .analysisTapped:
                state.destination = .analysis(FinancialAnalyticsFeature.State())
                return .none
            case .destination(_):
                return .none
            case .loadTestScore:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension ProfileFeature {
    @Reducer(state: .equatable)
    enum Destination {
        case test(ScoreTestFeature)
        case analysis(FinancialAnalyticsFeature)
    }
}
