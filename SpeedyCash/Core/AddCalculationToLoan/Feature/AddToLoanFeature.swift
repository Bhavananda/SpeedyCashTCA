//
//  AddToLoanFeature.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 30.04.2025.
//

import Foundation
import ComposableArchitecture

//@Reducer
//struct AddToLoanFeature {
//    
//    @ObservableState
//    struct State: Equatable {
//        var loanName: String = ""
//        var loanIcon: String = ""
//        var showSuccessAlert: Bool = false
//        
//        var isSaveDisabled: Bool {
//            loanName.isEmpty || loanIcon.isEmpty
//        }
//    }
//    
//    enum Action {
//        case nameChanged(String)
//        case iconChanged(String)
//        case saveTapped
//        case cancelTapped
//        case alertDismissed
//    }
//    
//    var body: some ReducerOf<Self> {
//        Reduce { state, action in
//            switch action {
//            case .nameChanged(let name):
//                state.loanName = name
//                return .none
//                
//            case .iconChanged(let icon):
//                state.loanIcon = icon
//                return .none
//                
//            case .saveTapped:
//                // Тут ми нічого не робимо — закривати буде parent
//                return .none
//                
//            case .cancelTapped:
//                return .none
//            case .alertDismissed:
//                state.showSuccessAlert = false
//                return .send(.delegate(.finished))
//            case .delegate:
//                return .none
//            }
//        }
//    }
//}

