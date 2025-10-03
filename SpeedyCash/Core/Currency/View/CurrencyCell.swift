//
//  CurrencyCell.swift
//  SpeedyCash
//
//  Created by Bhavananda Das on 12.06.2025.
//

import SwiftUI

struct CurrencyCell: View {
    
    let currency: CurrencyModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 0) {
                Text("\(currency.flag) \(currency.code.uppercased())")
                Spacer()
                Text("\(currency.rate.formatted) USD")
                
            }
            Text("\(currency.currencyName)")
                .foregroundStyle(.gray)
        }
        .font(.poppins(.regular ,size: 14))
        .foregroundStyle(.black)
        .padding(15)
        .background(.white)
        .clipShape(.rect(cornerRadius: 24))
    }
}

//#Preview {
//    CurrencyCell()
//}
