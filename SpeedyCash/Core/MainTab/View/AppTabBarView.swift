//
//  AppTabBarView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 24.02.2025.
//

import SwiftUI
import ComposableArchitecture

struct AppTabBarView: View {
    
    @Bindable var store: StoreOf<TabBarFeature>
    
    var body: some View {
        WithViewStore(store, observe: \.self) { viewStore in
            CustomTabBarContainerView(selection: $store.selectedPage.sending(\.selectTab)) {
                
                ProfileView(
                    store: store.scope(state: \.profileState, action: \.profile)
                )
                .tabBarItem(.home, selection: $store.selectedPage.sending(\.selectTab))
                
                OffersView(
                    store: store.scope(state: \.offersState, action: \.offers)
                )
                .tabBarItem(.offers, selection: $store.selectedPage.sending(\.selectTab))
                
                CalculatorView(
                    store: store.scope(state: \.calculatorState, action: \.calculator)
                )
                .tabBarItem(.calculator, selection: $store.selectedPage.sending(\.selectTab))
                
                SettingsScreen(
                    store: store.scope(state: \.settingsState, action: \.settings)
                )
                .tabBarItem(.settings, selection: $store.selectedPage.sending(\.selectTab))
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AppTabBarView(store: Store(initialState: TabBarFeature.State(), reducer: {
        TabBarFeature()
    }))
}
