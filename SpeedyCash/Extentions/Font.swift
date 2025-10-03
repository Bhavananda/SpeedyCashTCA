//
//  Font+Roboto.swift
//  Bravo!
//
//  Created by Bhavananda das on 25.07.2024.
//

import SwiftUI

extension Font{
    enum Poppins: String{
        case regular = "Poppins-Regular"
        case medium = "Poppins-Medium"
        case semiBold = "Poppins-SemiBold"
        case bold = "Poppins-Bold"
    }
    
    static func poppins(_ type: Poppins = .regular, size: CGFloat) -> Font{
        return .custom(type.rawValue, size: size)
    }
}
