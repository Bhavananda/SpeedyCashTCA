//
//  Transition.swift
//  LoanMaster
//
//  Created by Bhavananda das on 17.02.2025.
//

import SwiftUI

extension AnyTransition {
    /// Переходи вперед
    static var slideForward: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading)
        )
    }
    
    /// Переходи назад
    static var slideBackward: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .leading),
            removal: .move(edge: .trailing)
        )
    }
}


enum TransitionDirection {
    case forward
    case backward
}
