//
//  DataServiceClient.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 29.04.2025.
//

import Foundation
import Dependencies
import Combine

struct DataServiceClient {
    var loansPublisher: () -> AnyPublisher<[Loan], Never>
    var calculationsPublisher: () -> AnyPublisher<[Loan], Never>
    var testPublisher: () -> AnyPublisher<Double, Never>
    var addOrUpdateLoan: (Loan) -> Void
    var addCalculation: (Loan) -> Void
    var deleteLoan: (Loan) -> Void
    var deleteCalculation: (Loan) -> Void
    var setResult: (Double) -> Void
    var moveCalculationToLoan: (Loan) -> Void
}

extension DependencyValues {
    var dataService: DataServiceClient {
        get { self[DataServiceClientKey.self] }
        set { self[DataServiceClientKey.self] = newValue }
    }
}

private enum DataServiceClientKey: DependencyKey {
    static let liveValue: DataServiceClient = {
        let service = DataService()
        return DataServiceClient(
            loansPublisher: { service.$loans.eraseToAnyPublisher() },
            calculationsPublisher: {service.$calculations.eraseToAnyPublisher()},
            testPublisher: {service.$testResult.eraseToAnyPublisher()},
            addOrUpdateLoan: service.addOrUpdate(loan:),
            addCalculation: service.add(calculation:),
            deleteLoan: service.delete(loan:),
            deleteCalculation: service.delete(calculation: ),
            setResult: service.set(result:),
            moveCalculationToLoan: service.moveCalculationToLoan(calculation:)
        )
    }()
    
    static let testValue = DataServiceClient(
            loansPublisher: { Empty().eraseToAnyPublisher() },
            calculationsPublisher: { Empty().eraseToAnyPublisher() },
            testPublisher: { Empty().eraseToAnyPublisher() },
            addOrUpdateLoan: { _ in },
            addCalculation: { _ in },
            deleteLoan: { _ in },
            deleteCalculation: { _ in },
            setResult: { _ in },
            moveCalculationToLoan: { _ in }
        )
}
