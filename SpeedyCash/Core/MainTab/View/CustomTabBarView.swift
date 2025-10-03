//
//  CustomTabBarView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 24.02.2025.
//

import SwiftUI

struct CustomTabBarView: View {
    let tabs: [MainTapPage]
    @Binding var selection: MainTapPage
    @State var localSelection: MainTapPage
    
    init(tabs: [MainTapPage] = MainTapPage.allCases, selection: Binding<MainTapPage>, localSelection: MainTapPage) {
        self.tabs = tabs
        self._selection = selection
        self._localSelection = State(initialValue: localSelection)
    }
    var body: some View {
        HStack(alignment: .top,spacing: 0) {
            ForEach(tabs, id: \.self) { page in
                let isSelected: Bool = localSelection == page
                tabView(tab: page, isSelected: isSelected)
                    .onTapGesture {
                        switchToTab(tab: page)
                    }
            }
        }
        .padding(EdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16))
        .background(.white)
        .onChange(of: selection) { oldValue, newValue in
            withAnimation(.easeInOut) {
                localSelection = selection
            }
        }
    }
}

#Preview {
    CustomTabBarView(tabs: MainTapPage.allCases, selection: .constant(.home), localSelection: .home)
}

extension CustomTabBarView {
    @ViewBuilder
    private func tabView(tab: MainTapPage, isSelected: Bool) -> some View {
        VStack(spacing: 0) {
            if isSelected {
                Text(tab.title)
                    .font(.poppins(.medium, size: 14))
                Circle()
                    .fill(Color(hex: "E04E68"))
                    .frame(width: 4, height: 4)
            } else {
                Image(tab.icon)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func switchToTab(tab: MainTapPage) {
        selection = tab
    }
}
