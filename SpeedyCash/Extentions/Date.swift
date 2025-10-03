//
//  Date+String.swift
//  Peso
//
//  Created by Bhavananda das on 30.08.2024.
//

import Foundation

extension Date{
    
    var fullSlashedDate: String{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
    
    var fullDottedDate: String{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
    
    var fullLinedDate: String{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: self)
    }
    
    var fullDate: String{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter.string(from: self)
    }
    
    var numDay: String{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    
    var shortMonth: String{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MMM."
        return formatter.string(from: self)
    }
    
    var month: String{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MMMM"
        return formatter.string(from: self)
    }
    
    var shortMonthAndDaySlashed: String{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: self)
    }
    
    var monthAndDay: String{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MMMM, dd"
        return formatter.string(from: self)
    }
    
    var shortFullDate: String{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: self)
    }
    
    var monthAndYear: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MMMM, yyyy"
        return formatter.string(from: self)
    }
    
    var shortDayOfWeek: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "EEE"
        return formatter.string(from: self)
    }
    
    var dayFromDate: Int{
        return Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
    }
}

extension Date {
    init?(from string: String, format: String = "dd.MM.yyyy", locale: String = "uk_UA") {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: locale)
        
        if let date = dateFormatter.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
}
