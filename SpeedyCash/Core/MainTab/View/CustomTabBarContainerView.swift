//
//  CustomTabBarContainerView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 24.02.2025.
//

import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
    
    @Binding var selection: MainTapPage
    let content: Content
    
    init(selection: Binding<MainTapPage>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    var body: some View {
        ZStack{
            content
        }
            .safeAreaInset(edge: .bottom) {
                CustomTabBarView(selection: $selection, localSelection: selection)
            }
    }
}

#Preview {
    CustomTabBarContainerView(selection: .constant(MainTapPage.offers)) {
        Color.red
    }
}
