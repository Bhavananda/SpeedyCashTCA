//
//  RoundedToxicButtonStyle.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 12.03.2025.
//

import SwiftUI

struct RoundedYellowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        RoundedYellowButton(configuration: configuration)
    }
}

extension ButtonStyle where Self == RoundedYellowButtonStyle {
    static var yellow: Self {
        .init()
    }
}

//#Preview {
//    RoundedDarkGreenButtonStyle()
//}

fileprivate struct RoundedYellowButton: View {
    @Environment(\.isEnabled) private var isEnabled: Bool
    let configuration: ButtonStyleConfiguration
    
    var body: some View {
        configuration.label
            .font(.poppins(.medium, size: 17))
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(backgroundColor, in: .rect(cornerRadius: 40))
            .contentShape(RoundedRectangle(cornerRadius: 40))
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
    
    private var backgroundColor: Color {
        isEnabled ?
        Color.accentYellow
        :
        Color(hex: "D5D5D5")
    }
}
