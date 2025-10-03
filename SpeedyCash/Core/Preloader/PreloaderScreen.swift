//
//  PreloaderScreen.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 25.04.2025.
//

import SwiftUI
import ComposableArchitecture

struct PreloaderScreen: View {
    
    @Bindable var store: StoreOf<PreloaderFeature>
    
    
    var body: some View {
        NavigationStack {
            NavigationView {
                VStack(spacing: 24) {
                    VStack(spacing: 12) {
                        Image(.preloaderIcon)
                        Group {
                            Text("Speedy")
                                .foregroundStyle(.black)
                            +
                            Text(" cash")
                                .foregroundStyle(Color(hex: "4DF1A4"))
                        }
                        .font(.poppins(.bold, size: 36))
                    }
                    CircleAngularProgressView()
                }
                .bgWhiteWithBlur(alignment: .center)
            }
            .navigationDestination(item: $store.scope(state: \.destination?.onboarding, action: \.destination.onboarding)) { store in
                OnboardingView(store: store)
            }
            .navigationDestination(item: $store.scope(state: \.destination?.mainTab, action: \.destination.mainTab)) { store in
                AppTabBarView(store: store)
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview {
    PreloaderScreen(store: Store(initialState: PreloaderFeature.State(), reducer: {
        PreloaderFeature()
    }))
}
