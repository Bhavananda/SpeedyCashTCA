//
//  OutcomeModel.swift
//  Peso
//
//  Created by Bhavananda das on 02.09.2024.
//

import Foundation

// MARK: - Loan Model

/// Основна модель позики
struct Loan: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var icon: String
    var amount: LoanAmount
    var dates: LoanDates
    var payments: [Payment]
    var rating: LoanRating
    var state: LoanState
    var type: LoanType
    
    init(id: UUID = UUID(),
         name: String = "",
         icon: String = "",
         amount: LoanAmount,
         dates: LoanDates,
         payments: [Payment] = [],
         rating: LoanRating,
         state: LoanState = .active,
         type: LoanType = .calculation
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.amount = amount
        self.dates = dates
        self.payments = payments
        self.rating = rating
        self.state = state
        self.type = type
    }
}

// MARK: - Loan Business Logic

extension Loan {
    
    /// Відсоток погашення позики (від 0 до 1)
    var progress: Double {
        amount.totalPaid / amount.totalPayable
    }
    
    /// Відсоток погашення у відсотках (ціле число)
    var progressPercentage: Int {
        Int(progress * 100)
    }
    
    /// Залишок, що потрібно сплатити
    var remainingAmount: Double {
        max(amount.totalPayable - amount.totalPaid, 0)
    }
    
    mutating func addMonthlyPayment() {
        if let index = payments.firstIndex(where: {$0.status != .completed}) {
            payments[index].status = .completed
            let updatedTotalPaid = amount.totalPaid + amount.monthlyPayment
            if updatedTotalPaid < amount.totalPayable {
                amount.totalPaid = updatedTotalPaid
            } else {
                completeLoan()
            }
        }
    }
    
    mutating func completeLoan() {
        for index in payments.indices {
            if payments[index].status != .completed{
                payments[index].status = .completed
            }
        }
        amount.totalPaid = amount.totalPayable
        dates.paidOffDate = Date()
        state = .completed
    }
}

// MARK: - LoanAmount

/// Модель, що описує фінансові параметри позики
struct LoanAmount: Codable, Hashable {
    var principal: Double        // Початкова сума позики
    var interestRate: Double     // Річна процентна ставка (у відсотках)
    var termInMonths: Int        // Термін позики у місяцях
    
    var monthlyPayment: Double   // Щомісячний платіж, розрахований за ануїтетною схемою
    var totalPayable: Double     // Загальна сума до сплати (principal + переплата)
    var totalPaid: Double        // Загальна сплачена сума
    var interestPaid: Double
    
    /// Ініціалізатор, який розраховує щомісячний платіж і загальну суму до сплати
    init(principal: Double, interestRate: Double, termInMonths: Int, downPayment: Double) {
        self.principal = principal
        self.interestRate = interestRate
        self.termInMonths = termInMonths
        let principalWithDownPayment = principal - downPayment
        self.monthlyPayment = LoanCalculator.calculateMonthlyPayment(principal: principalWithDownPayment,
                                                                     annualRate: interestRate,
                                                                     termInMonths: termInMonths)
        self.totalPayable = LoanCalculator.calculateTotalPayable(principal: principalWithDownPayment,
                                                                 monthlyPayment: monthlyPayment,
                                                                 termInMonths: termInMonths)
        self.totalPaid = 0
        self.interestPaid = totalPayable - principalWithDownPayment
    }
}

// MARK: - LoanDates

/// Модель, що містить дати, пов’язані з позикою
struct LoanDates: Codable, Hashable {
    var startDate: Date         // Дата початку позики
    var endDate: Date           // Дата завершення позики
    var reminderDate: Date?     // Дата нагадування про платіж
    var paidOffDate: Date?      // Дата повного погашення позики
    
    /// Ініціалізатор з вирахуванням кінцевої дати позики
    init(startDate: Date, termInMonths: Int, reminderDate: Date? = nil) {
        self.startDate = startDate
        self.endDate = Calendar.current.date(byAdding: .month, value: termInMonths, to: startDate) ?? startDate
        self.reminderDate = reminderDate
        self.paidOffDate = nil
    }
}

// MARK: - Payment

/// Модель платежу
struct Payment: Identifiable, Codable, Hashable {
    let id: UUID
    let date: Date
    let amount: Double
    let number: Int
    let totalCount: Int
    var status: PaymentStatus
    
    init(id: UUID = UUID(), date: Date = Date(), amount: Double, number: Int = 0, totalCount: Int = 0, status: PaymentStatus = .future) {
        self.id = id
        self.date = date
        self.amount = amount
        self.number = number
        self.totalCount = totalCount
        self.status = status
    }
}

/// Статус платежу
enum PaymentStatus: String, Codable {
    case completed
    case overdue
    case future
}

// MARK: - LoanState

/// Стан позики
enum LoanState: String, Codable {
    case active
    case completed
}

enum LoanType: String, Codable {
    case calculation
    case loan
}

extension LoanType: SegmentedPickerEnum {}

// MARK: - LoanCalculator

/// Сервіс для розрахунків, пов’язаних з позикою
struct LoanCalculator {
    static func calculateMonthlyPayment(principal: Double, annualRate: Double, termInMonths: Int) -> Double {
        let monthlyRate = (annualRate / 100) / 12
        if monthlyRate == 0 {
            return (principal / Double(termInMonths)).rounded(toPlaces: 2)
        }
        
        let numerator = monthlyRate * pow(1 + monthlyRate, Double(termInMonths))
        let denominator = pow(1 + monthlyRate, Double(termInMonths)) - 1
        
        return (principal * numerator / denominator).rounded(toPlaces: 2)
    }
    
    static func generatePayments(startDate: Date, term: Int, monthlyPayment: Double) -> [Payment] {
        (1...term).compactMap { item in
            guard let date = Calendar.current.date(byAdding: .month, value: item, to: startDate) else {
                return nil
            }
            return Payment(
                date: date,
                amount: monthlyPayment,
                number: item,
                totalCount: term,
                status: .future
            )
        }
    }
    
    static func calculateTotalPayable(principal: Double, monthlyPayment: Double, termInMonths: Int) -> Double {
        (monthlyPayment * Double(termInMonths)).rounded(toPlaces: 2)
    }
    
    static func calculateLoanRating(interestRate: Double) -> LoanRating {
        switch interestRate {
            case ..<4:
                return .good
            case 4..<12:
            return .average
            default:
            return .good
            }
        }
}

enum LoanRating: Codable, Hashable {
    case poor
    case average
    case good
    
    var title: String {
        switch self {
        case .poor:
            "Poor Terms"
        case .average:
            "Average Terms"
        case .good:
            "Good Terms"
        }
    }
    
    var icon: String {
        switch self {
        case .poor:
            "poor"
        case .average:
            "average"
        case .good:
            "good"
        }
    }
    
    var foregroundColorHex: String {
        switch self {
        case .poor:
            "FF3B30"
        case .average:
            "FF9500"
        case .good:
            "34C759"
        }
    }
    
    var backgroundColorHex: String {
        switch self {
        case .poor:
            "FEECEB"
        case .average:
            "FFEFD9"
        case .good:
            "E1F7E6"
        }
    }
}
