//
//  FinancialAnalyticsFeature.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 05.05.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct  FinancialAnalyticsFeature {
    
    @ObservableState
    struct State: Equatable {
        var loanAmount: String = ""
        var tin: String = ""
        var dateOfBirth: String = ""
        var email: String = ""
        var phoneNumber: String = ""
        
        var amountIsValid: Bool = false
        var tinIsValid: Bool = false
        var dateOfBirthIsValid: Bool = false
        var emailIsValid: Bool = false
        var phoneNumberIsValid: Bool = false
        
        var currentPage: CreationPage = .first
        var showFinishAlert: Bool = false
        
        var isNextDisable: Bool {
            !amountIsValid || !tinIsValid || !dateOfBirthIsValid
        }
        
        var isGetResultDisable: Bool {
            !emailIsValid || !phoneNumberIsValid
        }
    }
    
    enum Action {
        case loanAmountChanged(String)
        case tinChanged(String)
        case dateOfBirthChanged(String)
        case emailChanged(String)
        case phoneNumberChanged(String)
        
        case amountValidationResultChanged(Bool)
        case tinValidationResultChanged(Bool)
        case dateOfBirthValidationResultChanged(Bool)
        case emailValidationResultChanged(Bool)
        case phoneNumberValidationResultChanged(Bool)
        
        case nextPageTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .loanAmountChanged(newValue):
                state.loanAmount = newValue
                return .none
            case let .tinChanged(newValue):
                state.tin = newValue
                return .none
            case let .dateOfBirthChanged(newValue):
                state.dateOfBirth = newValue
                return .none
            case let .emailChanged(newValue):
                state.email = newValue
                return .none
            case let .phoneNumberChanged(newValue):
                state.phoneNumber = newValue
                return .none
            case let .amountValidationResultChanged(newValue):
                state.amountIsValid = newValue
                return .none
            case let .tinValidationResultChanged(newValue):
                state.tinIsValid = newValue
                return .none
            case let .dateOfBirthValidationResultChanged(newValue):
                state.dateOfBirthIsValid = newValue
                return .none
            case let .emailValidationResultChanged(newValue):
                state.emailIsValid = newValue
                return .none
            case let .phoneNumberValidationResultChanged(newValue):
                state.phoneNumberIsValid = newValue
                return .none
            case .nextPageTapped:
                switch state.currentPage {
                case .first: state.currentPage = .second
                case .second: state.showFinishAlert = true
                }
                return .none
            }
        }
    }
}
