//
//  PaymentHistory.swift
//  CreditToSpill
//
//  Created by Bhavananda das on 10.03.2025.
//

import Foundation

struct PaymentHistory: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var payment: Payment
    var loan: Loan
}

struct PaymentsHistoryGroupedByMonth: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var month: String
    var payments: [PaymentHistory]
}
