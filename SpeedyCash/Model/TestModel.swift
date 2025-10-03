//
//  TestModel.swift
//  Taja
//
//  Created by Bhavananda das on 31.05.2024.
//

import Foundation
struct QuestionModel: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var question: String
    var selectedAnswer: Int?
    var answers: [AnswerModel]
    
}

struct AnswerModel: Identifiable, Hashable{
    var id: String = UUID().uuidString
    var answer: String
    var value: Int
}

struct Questions {
    static let questions: [QuestionModel] = [
        QuestionModel(question: "How often do you pay your bills on time?", answers: [
            AnswerModel(answer: "Always", value: 43),
            AnswerModel(answer: "Usually", value: 33),
            AnswerModel(answer: "Sometimes", value: 24),
            AnswerModel(answer: "Rarely", value: 15)
        ]),
        
        QuestionModel(question: "What is your current credit card balance?", answers: [
            AnswerModel(answer: "Very low", value: 43),
            AnswerModel(answer: "Moderate", value: 33),
            AnswerModel(answer: "High", value: 24),
            AnswerModel(answer: "Maxed out", value: 15)
        ]),
        
        QuestionModel(question: "How many credit cards do you have?", answers: [
            AnswerModel(answer: "None", value: 24),
            AnswerModel(answer: "1-2", value: 43),
            AnswerModel(answer: "3-5", value: 33),
            AnswerModel(answer: "More than 5", value: 15)
        ]),
        
        QuestionModel(question: "How long is your credit history?", answers: [
            AnswerModel(answer: "Over 10 years", value: 43),
            AnswerModel(answer: "5-10 years", value: 33),
            AnswerModel(answer: "1-5 years", value: 24),
            AnswerModel(answer: "Less than 1 year", value: 15)
        ]),
        
        QuestionModel(question: "Do you have any missed loan payments?", answers: [
            AnswerModel(answer: "No", value: 43),
            AnswerModel(answer: "Once", value: 33),
            AnswerModel(answer: "A few times", value: 24),
            AnswerModel(answer: "Many times", value: 15)
        ]),
        
        QuestionModel(question: "What is your credit utilization rate?", answers: [
            AnswerModel(answer: "Less than 10%", value: 43),
            AnswerModel(answer: "10–30%", value: 33),
            AnswerModel(answer: "30–50%", value: 24),
            AnswerModel(answer: "Over 50%", value: 15)
        ]),
        
        QuestionModel(question: "Do you have any outstanding debts?", answers: [
            AnswerModel(answer: "No", value: 43),
            AnswerModel(answer: "Small amounts", value: 33),
            AnswerModel(answer: "Moderate", value: 24),
            AnswerModel(answer: "High amounts", value: 15)
        ]),
        
        QuestionModel(question: "How often do you apply for credit?", answers: [
            AnswerModel(answer: "Rarely", value: 43),
            AnswerModel(answer: "Occasionally", value: 33),
            AnswerModel(answer: "Often", value: 24),
            AnswerModel(answer: "Very often", value: 15)
        ]),
        
        QuestionModel(question: "Do you have a mortgage?", answers: [
            AnswerModel(answer: "Yes, fully paid", value: 43),
            AnswerModel(answer: "Yes, paying on time", value: 33),
            AnswerModel(answer: "Yes, with delays", value: 24),
            AnswerModel(answer: "No", value: 15)
        ]),
        
        QuestionModel(question: "Have you ever filed for bankruptcy?", answers: [
            AnswerModel(answer: "Never", value: 43),
            AnswerModel(answer: "Once", value: 33),
            AnswerModel(answer: "More than once", value: 24),
            AnswerModel(answer: "Multiple times", value: 15)
        ]),
        
        QuestionModel(question: "Do you monitor your credit score regularly?", answers: [
            AnswerModel(answer: "Yes, monthly", value: 43),
            AnswerModel(answer: "Yes, occasionally", value: 33),
            AnswerModel(answer: "Rarely", value: 24),
            AnswerModel(answer: "Never", value: 15)
        ]),
        
        QuestionModel(question: "Do you have different types of credit accounts?", answers: [
            AnswerModel(answer: "Yes, diverse mix", value: 43),
            AnswerModel(answer: "Some variety", value: 33),
            AnswerModel(answer: "One or two types", value: 24),
            AnswerModel(answer: "Only one type", value: 15)
        ]),
        
        QuestionModel(question: "Have you co-signed any loans?", answers: [
            AnswerModel(answer: "No", value: 43),
            AnswerModel(answer: "Yes, with responsible borrower", value: 33),
            AnswerModel(answer: "Yes, with some issues", value: 24),
            AnswerModel(answer: "Yes, with major issues", value: 15)
        ]),
        
        QuestionModel(question: "Do you have any collections on your credit report?", answers: [
            AnswerModel(answer: "None", value: 43),
            AnswerModel(answer: "One", value: 33),
            AnswerModel(answer: "Few", value: 24),
            AnswerModel(answer: "Many", value: 15)
        ]),
        
        QuestionModel(question: "How stable is your employment?", answers: [
            AnswerModel(answer: "Very stable", value: 43),
            AnswerModel(answer: "Stable", value: 33),
            AnswerModel(answer: "Somewhat unstable", value: 24),
            AnswerModel(answer: "Unstable", value: 15)
        ]),
        
        QuestionModel(question: "How much of your income goes toward debt?", answers: [
            AnswerModel(answer: "Less than 20%", value: 43),
            AnswerModel(answer: "20–35%", value: 33),
            AnswerModel(answer: "35–50%", value: 24),
            AnswerModel(answer: "Over 50%", value: 15)
        ]),
        
        QuestionModel(question: "Do you have emergency savings?", answers: [
            AnswerModel(answer: "Yes, over 6 months of expenses", value: 43),
            AnswerModel(answer: "3–6 months", value: 33),
            AnswerModel(answer: "Less than 3 months", value: 24),
            AnswerModel(answer: "None", value: 15)
        ]),
        
        QuestionModel(question: "How do you manage loan repayments?", answers: [
            AnswerModel(answer: "Always on time", value: 43),
            AnswerModel(answer: "Mostly on time", value: 33),
            AnswerModel(answer: "Sometimes late", value: 24),
            AnswerModel(answer: "Often late", value: 15)
        ]),
        
        QuestionModel(question: "Have you ever defaulted on a loan?", answers: [
            AnswerModel(answer: "Never", value: 43),
            AnswerModel(answer: "Once", value: 33),
            AnswerModel(answer: "Occasionally", value: 24),
            AnswerModel(answer: "Multiple times", value: 15)
        ]),
        
        QuestionModel(question: "Do you review your credit report for errors?", answers: [
            AnswerModel(answer: "Yes, regularly", value: 43),
            AnswerModel(answer: "Sometimes", value: 33),
            AnswerModel(answer: "Rarely", value: 24),
            AnswerModel(answer: "Never", value: 15)
        ])
    ]
    
    static let creditScoreExplanation: [(range: ClosedRange<Int>, description: String)] = [
        (781...850, "You have access to the best financial products with favorable terms. Approval also depends on other factors."),
        (720...780, "Your credit score is strong, and you're likely to qualify for good interest rates."),
        (660...719, "Your credit score is fair, though interest rates may be higher."),
        (600...659, "You may qualify for credit, but likely at higher interest rates."),
        (300...599, "Improving your credit habits will help raise your score.")
    ]
    
    static func scoreStatus(for score: Int) -> String {
        switch score {
        case 800...850:
            return "Excellent"
        case 740...799:
            return "Very Good"
        case 670...739:
            return "Good"
        case 580...669:
            return "Fair"
        case 300...579:
            return "Poor"
        default:
            return "Unknown"
        }
    }
}
