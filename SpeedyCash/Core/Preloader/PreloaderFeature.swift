//
//  PreloaderFeature.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 06.05.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct PreloaderFeature {
    
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
    }
    
    enum Action {
        case onAppear
        case timerFinished
        case destination(PresentationAction<Destination.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    try await Task.sleep(for: .seconds(2))
                    await send(.timerFinished)
                }
                
            case .timerFinished:
                if UserDefaults.standard.object(forKey: "openOnb") == nil {
                    UserDefaults.standard.set(true, forKey: "openOnb")
                    state.destination = .onboarding(OnboardingFeature.State())
                }else {
                    state.destination = .mainTab(TabBarFeature.State())
                }
                return .none
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension PreloaderFeature {
    @Reducer(state: .equatable)
    enum Destination {
        case onboarding(OnboardingFeature)
        case mainTab(TabBarFeature)
    }
}


