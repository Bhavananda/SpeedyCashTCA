//
//  AnalysisField.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 07.04.2025.
//

import SwiftUI

struct AnalysisField: View {
    @FocusState private var isFocused: Bool
    @Binding var text: String
    @Binding var isValid: Bool
    var type: FieldType

    init(text: Binding<String>, isValid: Binding<Bool>, type: FieldType) {
        _text = text
        _isValid = isValid
        self.type = type
    }
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            titleLabel
            textFieldLabel
        }
        .foregroundStyle(.black)
        .onChange(of: text, { oldValue, newValue in
            validateFieldInProcess()
        })
        .onChange(of: isFocused, { _, newValue in
            if !newValue {
                validateFieldAfterSubmit()
            }
        })
    }
}

#Preview {
    AnalysisField(text: .constant(""), isValid: .constant(false), type: .amount)
}

extension AnalysisField {
    private var titleLabel: some View {
        Text(title)
            .font(.poppins(.medium, size: 17))
    }
    
    private var textFieldLabel: some View {
        TextField("", text: $text, prompt: Text(prompt).foregroundStyle(.black.opacity(0.5)))
            .tint(.black)
            .font(.poppins(.regular, size: 17))
            .focused($isFocused)
            .padding(.trailing, 20)
            .overlay(alignment: .trailing, content: {
                if !text.isEmpty && isFocused {
                    cleanButton
                }
                
                if !text.isEmpty && !isFocused && !isValid {
                    Image(.invalidField)
                }
            })
            .padding(EdgeInsets(top: 9, leading: 16, bottom: 9, trailing: 16))
            .background(.white, in: .rect(cornerRadius: 24))
    }
    
    private var cleanButton: some View {
        Button {
            cleanField()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.black.opacity(0.2))
        }
    }
}

extension AnalysisField {
    
    enum FieldType {
        case amount
        case tin
        case birth
        case email
        case phoneNumber
    }
    
    private func cleanField() {
        text = ""
    }
    
    private var title: String {
        switch type {
        case .amount: "Amount"
        case .tin: "TIN"
        case .birth: "Date of Birth"
        case .email: "Email"
        case .phoneNumber: "Phone Number"
        }
    }
    
    private var prompt: String {
        switch type {
        case .amount: "$0.00"
        case .tin: "10-digit ID"
        case .birth: "DD/MM/YYYY"
        case .email: "example@email.com"
        case .phoneNumber: "+1 (___) ___ ____"
        }
    }
    
    private func validateFieldInProcess() {
        switch type {
        case .amount:
            break
        case .tin: validateTIN()
        case .birth:
            formatDateInput()
        case .email:
            break
        case .phoneNumber:
            validatePhoneNumber()
        }
    }
    
    private func validateFieldAfterSubmit() {
        switch type {
        case .amount:
            validateAmount()
        case .tin:
            break
        case .birth:
            validateBirth()
        case .email:
            validateEmail()
        case .phoneNumber:
            break
        }
    }
    
    private func validateAmount() {
        let raw = text.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
        if let amount = Double(raw) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = "$"
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            formatter.locale = Locale(identifier: "en_US")
            
            if let formatted = formatter.string(from: NSNumber(value: amount)) {
                text = formatted
                isValid = true
            }
        } else {
            text = "$0.00"
            isValid = false
        }
    }
    
    private func validateTIN() {
        let digits = text.filter(\.isNumber)
        text = String(digits.prefix(10))
        isValid = digits.count == 10
        
    }
    
    private func validateBirth() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        if let date = formatter.date(from: text) {
            let calendar = Calendar.current
            let now = Date()
            let age = calendar.dateComponents([.year], from: date, to: now).year ?? 0
            if age >= 18 {
                text = formatter.string(from: date)
                isValid = true
            } else {
                isValid = false
            }
        }
    }
    
    private func validateEmail() {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        if predicate.evaluate(with: text) {
            isValid = true
        } else {
            isValid = false
        }
        
    }
    
    private func validatePhoneNumber() {
        let pattern = "+1 (###) ###-####"
        text = applyPatternOnNumbers(text, pattern: pattern, replacementCharacter: "#")
        isValid = pattern.count == text.count
    }
    
    private func applyPatternOnNumbers(_ text: String, pattern: String, replacementCharacter: Character) -> String {
        // Витягуємо лише цифри з введеного тексту
        var cleanNumber = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // Знаходимо всі символи до першого replacementCharacter у шаблоні (це і є префікс, наприклад: "+1 ")
        if let firstReplacementIndex = pattern.firstIndex(of: replacementCharacter) {
            let prefix = pattern[..<firstReplacementIndex]
            let prefixDigits = prefix.filter { $0.isNumber }
            
            // Якщо ввід починається з коду країни — відрізаємо його
            if cleanNumber.hasPrefix(prefixDigits) {
                cleanNumber = String(cleanNumber.dropFirst(prefixDigits.count))
            }
        }
        
        // Формуємо відформатований результат
        var result = ""
        var index = cleanNumber.startIndex
        
        for char in pattern {
            if index >= cleanNumber.endIndex {
                break
            }
            
            if char == replacementCharacter {
                result.append(cleanNumber[index])
                index = cleanNumber.index(after: index)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
    
    private func formatDateInput() {
        let cleanText = text.filter { $0.isNumber }
        var result = ""
        
        for (index, char) in cleanText.enumerated() {
            if index == 2 || index == 4 {
                result.append("/")
            }
            result.append(char)
        }
        
        text = String(result.prefix(10))
    }
}
