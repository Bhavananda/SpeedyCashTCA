//
//  MockData.swift
//  PesoQ_Pautang Peso
//
//  Created by Bhavananda das on 20.01.2025.
//

import Foundation

private let now = Date()
private let calendar = Calendar.current

/// Функція для отримання дати, зміщеної на певну кількість місяців від базової дати
private func dateByAdding(months: Int, to baseDate: Date = now) -> Date {
    calendar.date(byAdding: .month, value: months, to: baseDate) ?? baseDate
}

struct MockData{
//    
//    static let statistics: [StatisticModel] = [
//        StatisticModel(category: .paid, value: 6000, colorHex: "FF6B3F"),
//        StatisticModel(category: .left, value: 14000, colorHex: "CCCCCC")
//    ]
//    
//    static let lentStatistics: [StatisticModel] = [
//        StatisticModel(category: .paid, value: 6000, colorHex: "92C1AF"),
//        StatisticModel(category: .left, value: 14000, colorHex: "CCCCCC")
//    ]
    
    
    static let mockLoans: [Loan] = {
        // ===== 1. Позика "Car Loan" (Активна, частково сплачена) =====
        let carLoanAmount = LoanAmount(principal: 10_000,
                                       interestRate: 5,
                                       termInMonths: 24, downPayment: 0)
        let carLoanDates = LoanDates(startDate: dateByAdding(months: -3),
                                     termInMonths: 24)
        
        // Створюємо декілька платежів
        let carPayment1 = Payment(date: dateByAdding(months: -3),
                                  amount: carLoanAmount.monthlyPayment, status: .completed)
        let carPayment2 = Payment(date: dateByAdding(months: -2),
                                  amount: carLoanAmount.monthlyPayment, status: .completed)
        
        var carLoan = Loan(name: "Car Loan",
                           icon: "info",
                           amount: carLoanAmount,
                           dates: carLoanDates,
                           payments: [carPayment1, carPayment2],
                           rating: .average,
                           state: .active)
        // Оновлюємо суму сплачену по позиці
        carLoan.amount.totalPaid = carPayment1.amount + carPayment2.amount
        
        // ===== 2. Позика "Home Loan" (Завершена) =====
        let homeLoanAmount = LoanAmount(principal: 50_000,
                                        interestRate: 3.5,
                                        termInMonths: 120, downPayment: 0)
        let homeLoanDates = LoanDates(startDate: dateByAdding(months: -60),
                                      termInMonths: 120)
        
        // Симулюємо погашення позики одним фінальним платежем, що дорівнює totalPayable
        let homePayment = Payment(date: now,
                                  amount: homeLoanAmount.totalPayable, status: .completed)
        var homeLoan = Loan(name: "Home Loan",
                            icon: "info",
                            amount: homeLoanAmount,
                            dates: homeLoanDates,
                            payments: [homePayment],
                            rating: .good, state: .completed)
        homeLoan.amount.totalPaid = homeLoanAmount.totalPayable
        homeLoan.dates.paidOffDate = now
        
        // ===== 3. Позика "Student Loan" (Активна, в процесі погашення) =====
        let studentLoanAmount = LoanAmount(principal: 20_000,
                                           interestRate: 7,
                                           termInMonths: 60, downPayment: 0)
        let studentLoanDates = LoanDates(startDate: dateByAdding(months: -12),
                                         termInMonths: 60)
        
        // Створимо кілька платежів для цієї позики
        let studentPayment1 = Payment(date: dateByAdding(months: -12),
                                      amount: studentLoanAmount.monthlyPayment, status: .completed)
        let studentPayment2 = Payment(date: dateByAdding(months: -8),
                                      amount: studentLoanAmount.monthlyPayment,
                                      status: .completed)
        let studentPayment3 = Payment(date: dateByAdding(months: -4),
                                      amount: studentLoanAmount.monthlyPayment,
                                      status: .completed)
        
        var studentLoan = Loan(name: "Student Loan",
                               icon: "loan3",
                               amount: studentLoanAmount,
                               dates: studentLoanDates,
                               payments: [studentPayment1, studentPayment2, studentPayment3],
                               rating: .poor,
                               state: .active)
        studentLoan.amount.totalPaid = studentPayment1.amount + studentPayment2.amount + studentPayment3.amount
        
        // Повертаємо масив всіх позик
        return [carLoan, homeLoan, studentLoan]
    }()
    
    static let mockOffers: [OfferModel] = [
        OfferModel(
            objectId: "GbjlWxlWpD",
            interest: "từ 0%",
            link: "https://guberb.space/click?key=17b3015209868d52af2c&offer=Jeff",
            companyName: "Jeff",
            terms: "đến 12 tháng",
            order: 6,
            amount: "đến 30.000.000đ",
            topOffer: true,
            image: "https://firebasestorage.googleapis.com/v0/b/money-goals-558f9.appspot.com/o/VN_jeff.png?alt=media&token=43493ab2-fced-4a88-b5ae-3c3e60295b01",
            mark: "4.7",
            description: "Loan services up to 300,000₸ for up to 91 days."
        ),
        OfferModel(
            objectId: "HLjFTLshfl",
            interest: "từ 0%",
            link: "https://guberb.space/click?key=17b3015209868d52af2c&offer=CreditNice",
            companyName: "CreditNice",
            terms: "đến 12 tháng",
            order: 5,
            amount: "đến 10.000.000đ",
            topOffer: false,
            image: "https://firebasestorage.googleapis.com/v0/b/money-goals-558f9.appspot.com/o/VN_%20CreditNice.png?alt=media&token=321f0822-331c-49ab-9bef-acc768c5f180",
            mark: "4.7",
            description: "Quick loans up to 300,000₸ for up to 30 days."
        ),
        OfferModel(
            objectId: "d4ti9yd69U",
            interest: "từ 0%",
            link: "https://guberb.space/click?key=17b3015209868d52af2c&offer=Dong247",
            companyName: "Dong247",
            terms: "đến 12 tháng",
            order: 4,
            amount: "đến 10.000.000đ",
            topOffer: false,
            image: "https://firebasestorage.googleapis.com/v0/b/money-goals-558f9.appspot.com/o/VN_dong247.png?alt=media&token=fac27584-6c46-442e-ba38-604415747547",
            mark: "4.8",
            description: "Flexible loans up to 300,000₸ for up to 30 days."
        ),
        OfferModel(
            objectId: "onZi5OGldD",
            interest: "từ 0.01%",
            link: "https://guberb.space/click?key=17b3015209868d52af2c&offer=Visame",
            companyName: "Visame",
            terms: "đến 12 tháng",
            order: 2,
            amount: "đến 15.000.000đ",
            topOffer: false,
            image: "https://firebasestorage.googleapis.com/v0/b/money-goals-558f9.appspot.com/o/VN_visame.png?alt=media&token=4ed110c4-1f6a-44e0-ba56-69e1a2c34109",
            mark: "4.9",
            description: "Reliable financial solutions for up to 100 days."
        ),
        OfferModel(
            objectId: "juNDhUmYB3",
            interest: "từ 0.01%",
            link: "https://guberb.space/click?key=17b3015209868d52af2c&offer=Finloo",
            companyName: "Finloo",
            terms: "đến 12 tháng",
            order: 3,
            amount: "đến 20.000.000đ",
            topOffer: false,
            image: "https://firebasestorage.googleapis.com/v0/b/money-goals-558f9.appspot.com/o/VN_finloo.png?alt=media&token=dbdf12cd-c629-4f4b-8f55-85172cc8f014",
            mark: "4.8",
            description: "Affordable loans up to 300,000₸ for up to 100 days."
        ),
        OfferModel(
            objectId: "p1MEezElln",
            interest: "từ 0%",
            link: "https://guberb.space/click?key=17b3015209868d52af2c&offer=Crezu",
            companyName: "Crezu",
            terms: "đến 12 tháng",
            order: 1,
            amount: "đến 20.000.000đ",
            topOffer: false,
            image: "https://firebasestorage.googleapis.com/v0/b/money-goals-558f9.appspot.com/o/VN_Crezu.png?alt=media&token=1136b0d3-29ea-4375-96bd-cd899046f378",
            mark: "5",
            description: "Affordable loans up to 300,000₸ for up to 30 days."
        )
    ]
    
    static var disclaimer: String =
"""
Credit Product Terms
Loan Amount: From $500 to $50,000
Consumer Age: From 18 to 65 years
Loan Disbursement Methods: Transfer to the consumer’s current account, including use of payment card details
Annual Percentage Rate (APR): Maximum 32%
Minimum Repayment Period: 61 days
Maximum Repayment Period: 1 year
Initial Payment Due Date: 90 days
Legal Information and Disclosures
Provider: Rock Solid LTD

Ancillary Services: Information regarding the availability, list, and cost of ancillary services offered by the financial institution, credit intermediaries, and third parties—including the payment amount and the basis for its calculation—is provided in accordance with U.S. laws, including the Truth in Lending Act (TILA) and regulations from the Consumer Financial Protection Bureau (CFPB).

Rock Solid LTD does not automatically include or require additional services or fees beyond those explicitly agreed upon in the credit agreement.

Warnings
In case of default or partial non-compliance with repayment of the loan amount and/or payment of interest, a penalty of 3% of the outstanding balance per day may apply, not exceeding the legal limit set by federal and state consumer lending laws.
Non-fulfillment of loan obligations may affect the consumer’s credit report and future eligibility for loans.
Rock Solid LTD is prohibited from requiring the purchase of any goods or services from itself or affiliated entities as a condition for receiving consumer credit.
To make an informed decision, consumers are encouraged to explore alternative loan offers from other financial institutions.
The company may only amend credit agreements with mutual consent from both parties.
Consumers have the right to opt out of receiving marketing materials via remote communication channels.
Consumer repayment costs may vary depending on the selected payment method.
Notice Regarding Unauthorized Access
Consumers are advised to immediately notify Rock Solid LTD in case of unauthorized access to or modification of their data in the company’s remote servicing systems.

Right of Withdrawal
Consumers may withdraw from the credit agreement without stating a reason, provided the following conditions are met:

Written notice must be sent to the company within 14 calendar days from the date of signing and receiving a copy of the credit agreement, via email or registered mail to the address stated in the agreement.
Within 7 calendar days of submitting the notice, the consumer must return the full amount disbursed and pay interest for the time the funds were held, calculated at the agreed rate.
If the consumer fails to return the full credit amount and/or interest within the period specified, the withdrawal will be considered invalid and the agreement will remain legally binding.

Apple App Store Compliance
To comply with Apple App Store policies, the app must meet the following requirements:

Transparency and Accuracy: All credit product information must be presented clearly and truthfully, without misleading or exaggerated claims.
Privacy Policy: The app must include a comprehensive privacy policy explaining how user data is collected, used, and protected.
User Rights: Users must be able to delete their account and data in accordance with U.S. privacy laws, including CCPA and, where applicable, GDPR.
Legal Compliance: The app must comply with all applicable U.S. laws and regulations, including consumer protection, fair lending, and data security requirements.
Licensing and Authorization: If the app offers financial services, the developer must be a licensed financial entity or use a public API of such an entity in compliance with their terms.
No Deceptive Practices: The app must not use hidden features, misleading tactics, or manipulative design patterns.
📌 Rock Solid LTD adheres to U.S. consumer finance regulations and Apple’s platform guidelines to ensure fairness, data security, and transparency for all users.
"""
}
