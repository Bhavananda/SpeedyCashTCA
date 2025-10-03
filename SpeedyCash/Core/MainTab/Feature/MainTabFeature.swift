//
//  MainTabFeature.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 06.05.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct TabBarFeature {
    
    @ObservableState
    struct State: Equatable {
        var selectedPage: MainTapPage = .home
        var profileState = ProfileFeature.State()
        var offersState = OffersFeature.State()
        var calculatorState = CalculatorFeature.State()
        var settingsState = SettingsFeature.State()
    }
    
    enum Action {
        case selectTab(MainTapPage)
        
        case profile(ProfileFeature.Action)
        case offers(OffersFeature.Action)
        case calculator(CalculatorFeature.Action)
        case settings(SettingsFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .selectTab(let page):
                state.selectedPage = page
                return .none
            case .profile, .offers, .calculator, .settings:
                return .none
                
            }
        }
        Scope(state: \.profileState, action: \.profile) {
            ProfileFeature()
        }
        Scope(state: \.offersState, action: \.offers) {
            OffersFeature()
        }
        Scope(state: \.calculatorState, action: \.calculator) {
            CalculatorFeature()
        }
        Scope(state: \.settingsState, action: \.settings) {
            SettingsFeature()
        }
    }
}
