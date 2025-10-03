//
//  BackgroundWithBlur.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 29.04.2025.
//

import SwiftUI

struct BackgroundWithBlur: ViewModifier {
    
    let alignment: Alignment

    func body(content: Content) -> some View {
        ZStack(alignment: alignment) {
            Color.bgWhite
                .overlay {
                    Image(.preloaderBG)
                        .resizable()
                        .scaledToFill()
                    
                }
                .ignoresSafeArea()
            content
        }
    }
}


extension View {
    func bgWhiteWithBlur(alignment: Alignment = .top) -> some View {
        self.modifier(BackgroundWithBlur(alignment: alignment))
    }
}
