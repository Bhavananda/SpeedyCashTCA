//
//  CalculationCreationSlider.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 29.04.2025.
//

import SwiftUI

struct CalculationCreationSlider: View {
    
    var calculationStyle: CalculationCreationSliderStyle
//    var value: Double
//    var onChange: (Double) -> Void
    @Binding var value: Double
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 4) {
                Text(calculationStyle.title)
                    .font(.poppins(.medium, size: 17))
                    .foregroundStyle(.black)
                Text(valueTitle(value))
                    .font(.poppins(.medium, size: 17))
                    .foregroundStyle(.accentOrange)
                    .contentTransition(.numericText())
                    .animation(.default, value: value)
            }
            sliderLabel
        }
    }
}

//#Preview {
//    CalculationCreationSlider(calculationStyle: .amount)
//}

extension CalculationCreationSlider {
//    value: Binding(
//        get: { value },
//        set: { onChange($0) }
//    )
    private var sliderLabel: some View {
        VStack(spacing: 12) {
            CustomSlider(
                value: $value,
                in: calculationStyle.range,
                step: calculationStyle.step,
                barStyle: (24.0, 24.0),
                fillBackground: .white,
                fillTrack: Color.accentOrange,
                thumbView: {
                Circle()
                    .fill(Color.white)
                    .frame(width: 12, height: 12)
                    .frame(width: 24, height: 24)
                
            })
            .frame(height: 24)
            HStack{
                Text(valueTitle(calculationStyle.range.lowerBound))
                Spacer()
                Text(valueTitle(calculationStyle.range.upperBound))
            }
            .font(.poppins(.regular, size: 14))
            .foregroundStyle(.black.opacity(0.5))
        }
        
    }
    
    
    func valueTitle(_ value: Double) -> String {
        switch calculationStyle {
        case .amount: value.descriptionWithDolarSign
        case .interest: value.intPercentDescription
        }
    }
}


enum CalculationCreationSliderStyle: String, CaseIterable {
    case amount
    case interest
    
    var title: String {
        switch self {
        case .amount: "Amount"
        case .interest: "Interest Rate"
        }
    }
    
    var step: Double {
        switch self {
        case .amount:
            100
        case .interest:
            1
        }
    }
    
    var range: ClosedRange<Double> {
        switch self {
        case .amount:
            0...100_000
        case .interest:
            0...36
        }
    }
}
