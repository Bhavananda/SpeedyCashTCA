//
//  Double+Description.swift
//  MobilePocket
//
//  Created by Bhavananda das on 25.06.2024.
//

import Foundation
extension Double{
    
    var formatted: String {
            let formattedString = String(format: "%.2f", self)
            return formattedString.hasSuffix(".00") ? String(format: "%.0f", self) : formattedString
        }
    
    var descriptionWithComa: String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        let number = NSNumber(value: self )
        return formatter.string(from: number)!
    }
    
    var intPercentDescription: String{
        let intValue = Int(self)
        return intValue.description + "%"
    }
    
    var intDescription: String{
        let intValue = Int(self)
        return intValue.description
    }
    
    var descriptionWithDolarSign: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        let number = NSNumber(value: self )
        return "$" + formatter.string(from: number)!
    }
    
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Int{
    var descriptionWithComa: String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = ","
        let number = NSNumber(value: self )
        return formatter.string(from: number)!
    }
    
    var percentDescription: String{
        return self.description + "%"
    }
}
