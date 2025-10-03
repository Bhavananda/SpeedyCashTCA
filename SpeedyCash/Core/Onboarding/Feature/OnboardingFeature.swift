//
//  OnboardingFeature.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 25.04.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct OnboardingFeature {
    
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
        var currentPage: OnboardingPages = .first
        var screenInfo: [OnboardingModel] =
        [
            OnboardingModel(image: .onboarding1, title: "Know Your Credit Score", subtitle: "Track your credit health and get smart financial insights to improve it ", page: .first),
            OnboardingModel(image: .onboarding2, title: "Plan Before Borrowing", subtitle: "Create custom loan calculations to estimate payments and compare terms ", page: .second),
            OnboardingModel(image: .onboarding3, title: "Manage Your Loans", subtitle: "Keep track of who owes whom. Stay organized, whether lending or borrowing", page: .third)
        ]
    }
    
    enum Action {
        case nextPageTapped
        case skipTapped
        case destination(PresentationAction<Destination.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .nextPageTapped:
                switch state.currentPage {
                case .first:
                    state.currentPage = .second
                    return .none
                case .second:
                    state.currentPage = .third
                    return .none
                case .third:
                    return .send(.skipTapped)
                }
            case .skipTapped:
                state.destination = .mainTab(TabBarFeature.State())
                return .none
            case .destination(_):
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension OnboardingFeature {
    @Reducer(state: .equatable)
    enum Destination {
        case mainTab(TabBarFeature)
    }
}
