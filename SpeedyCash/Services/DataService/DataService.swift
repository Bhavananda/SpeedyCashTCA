//
//  DataService.swift
//  LoanMaster
//
//  Created by Bhavananda das on 25.02.2025.
//

import Foundation

final class DataService {
    @Published var testResult: Double = 0
    @Published var loans: [Loan] = []
    @Published var calculations: [Loan] = []
    @Published var userEnterDate: Date = Date()
    private var user: User = User()
    
    private var saveService: Saveable = SavingService()

    init() {
        fetch()
        print("Data Service init")
    }
    
    // USER METHODS
    
    func set(result: Double) {
        testResult = result
        applyChanges()
    }
    
    func add(calculation: Loan) {
        calculations.append(calculation)
        applyChanges()
    }
    
    func delete(calculation: Loan) {
        if let index = calculations.firstIndex(where: {$0.id == calculation.id}){
            calculations.remove(at: index)
            applyChanges()
        }
    }
    
    func addOrUpdate(loan: Loan) {
        if let index = loans.firstIndex(where: {$0.id == loan.id}){
            loans[index] = loan
        } else {
            loans.append(loan)
        }
        applyChanges()
    }
    
    func moveCalculationToLoan(calculation: Loan) {
        if let index = calculations.firstIndex(where: {$0.id == calculation.id}){
            calculations.remove(at: index)
            addOrUpdate(loan: calculation)
            applyChanges()
        }
    }
    
    func delete(loan: Loan) {
        if let index = loans.firstIndex(where: {$0.id == loan.id}) {
            loans.remove(at: index)
            applyChanges()
        }
    }
    
    // PRIVATE
    
    private func applyChanges() {
        user.loans = loans
        user.calculations = calculations
        user.testResult = testResult
        save(user: user)
        fetch()
    }
    
    private func fetch(){
        if let savedUser: User = saveService.retrieveData(key: SavedToMemoryType.user.key){
            user = savedUser
            loans = user.loans
            calculations = user.calculations
            testResult = user.testResult
        }
    }
    
    private func save(user: User){
        saveService.saveData(encodeData: user, key: SavedToMemoryType.user.key)
    }

}


enum SavedToMemoryType {
  case user
    
    var key: String {
        switch self {
        case .user:
            "UserModel"
        }
    }
}
