//
//  TabBarItemsPreferenceKey.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 24.02.2025.
//

import Foundation
import SwiftUI

struct TabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [MainTapPage] = []
    
    static func reduce(value: inout [MainTapPage], nextValue: () -> [MainTapPage]) {
        value += nextValue()
    }
}


struct TabBarItemViewModifier: ViewModifier {
    let tab: MainTapPage
    @Binding var selection: MainTapPage
    func body(content: Content) -> some View {
        content
        //.transition(.)
            .opacity(tab == selection ? 1.0 : 0.0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View {
    func tabBarItem(_ tab: MainTapPage, selection: Binding<MainTapPage>) -> some View {
        modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}
