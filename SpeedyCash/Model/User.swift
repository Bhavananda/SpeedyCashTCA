//
//  User.swift
//  AllAdvanced
//
//  Created by Bhavananda das on 28.11.2024.
//

import Foundation
//import Algorithms

struct User: Codable{
    var loans: [Loan] = []
    var calculations: [Loan] = []
    var lastActivityDate: Date?
    var testResult: Double = 0
}

struct UserLoans: Codable{
    var loans: [Loan] = []
    
    var totalAmountDue: Double {
        calculateTotalAmountDue()
    }
    
    var totalLoans: Int {
        loans.count
    }
    
    var totalActiveLoans: Int {
        loans.filter({$0.state == .active}).count
    }
    
    var totalCompletedLoans: Int {
        loans.filter({$0.state == .completed}).count
    }
    var totalLoanAmount: Double {
        loans.reduce(0.0, {$0 + $1.amount.totalPayable})
    }
    
    var totalPaid: Double {
        loans.reduce(0.0, {$0 + $1.amount.totalPaid})
    }
}


extension UserLoans {
    fileprivate func calculateTotalAmountDue() -> Double{
        loans.reduce(0.0) { $0 + $1.remainingAmount }
    }
}



//MARK: Loans Methods

//extension User{
//    mutating func create(loan: Loan){
//        loansInfo.loans.append(loan)
//    }
//    
//    mutating func delete(loan: Loan){
//        loansInfo.loans.removeAll(where: {$0.id == loan.id})
//    }
//    
//    mutating func update(loan: Loan){
//        if let index = loansInfo.loans.firstIndex(where: {$0.id == loan.id}){
//            loansInfo.loans[index] = loan
//        }
//    }
//}
//
//extension User {
//    mutating func create(lent: Debt){
//        lentInfo.items.append(lent)
//    }
//    
//    mutating func delete(lent: Debt){
//        lentInfo.items.removeAll(where: {$0.id == lent.id})
//    }
//    
//    mutating func update(lent: Debt){
//        if let index = lentInfo.items.firstIndex(where: {$0.id == lent.id}){
//            lentInfo.items[index] = lent
//        }
//    }
//    
//    mutating func checkLents() {
//        for index in lentInfo.items.indices {
//            lentInfo.items[index].applyInterestIfNeeded()
//        }
//    }
//}

//extension User {
//    mutating func create(borrowing: Debt){
//        borrowingsInfo.items.append(borrowing)
//    }
//    
//    mutating func delete(borrowing: Debt){
//        borrowingsInfo.items.removeAll(where: {$0.id == borrowing.id})
//    }
//    
//    mutating func update(borrowing: Debt){
//        if let index = borrowingsInfo.items.firstIndex(where: {$0.id == borrowing.id}){
//            borrowingsInfo.items[index] = borrowing
//        }
//    }
//    
//    mutating func checkBorrowing() {
//        for index in borrowingsInfo.items.indices {
//            borrowingsInfo.items[index].applyInterestIfNeeded()
//        }
//    }
//}
