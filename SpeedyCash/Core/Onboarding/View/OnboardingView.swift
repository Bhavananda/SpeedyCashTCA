//
//  OnboardingView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 25.04.2025.
//

import SwiftUI
import ComposableArchitecture


struct OnboardingView: View {
    
    @Bindable var store: StoreOf<OnboardingFeature>

    
    var body: some View {
        ZStack(alignment: .top) {
            bg
            VStack(spacing: 24) {
                if let page = store.state.screenInfo.first(where: {$0.page == store.state.currentPage}){
                    pageView(page: page)
                        .transition(.slideForward)
                        .animation(.default, value: store.state.currentPage)
                }
                indicator
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .safeAreaPadding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden()
        .foregroundStyle(.black)
        .safeAreaInset(edge: .bottom) {
            nextButton
        }
        .safeAreaInset(edge: .top) {
            skipButton
        }
        .navigationDestination(item: $store.scope(state: \.destination?.mainTab, action: \.destination.mainTab)) { store in
            AppTabBarView(store: store)
        }
    }
}

#Preview {
    OnboardingView(store: Store(initialState: OnboardingFeature.State(), reducer: {
        OnboardingFeature()
    }))
}

extension OnboardingView {
    
    private var bg: some View {
        Color.bgWhite
            .overlay {
                Image(.onboardingBg)
                    .resizable()
                    .scaledToFill()
            }
            .ignoresSafeArea()
    }
    
    private func pageView(page: OnboardingModel) -> some View {
        VStack(spacing: 24) {
            Image(page.image)
                .resizable()
                .scaledToFit()
            VStack(alignment: .leading, spacing: 12) {
                Text(page.title)
                    .font(.poppins(.bold, size: 40))
                    .lineLimit(2, reservesSpace: true)
                Text(page.subtitle)
                    .font(.poppins(.regular, size: 17))
                    .lineLimit(2, reservesSpace: true)
                    .foregroundStyle(.black.opacity(0.5))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .id(page.page)
    }
    
    private var indicator: some View {
        HStack(spacing: 4) {
            ForEach(store.state.screenInfo) { page in
                if page.page == store.state.currentPage {
                    RoundedRectangle(cornerRadius: 22)
                        .fill(Color.black)
                        .frame(width: 32, height: 8)
                } else {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 8, height: 8)
                }
            }
            Spacer()
        }
    }
    
    private var nextButton: some View {
        Button("Next") {
            store.send(.nextPageTapped)
        }
        .buttonStyle(.yellow)
        .safeAreaPadding(.horizontal, 16)
    }
    
    private var skipButton: some View {
        Button {
            store.send(.skipTapped)
        } label: {
            Text("Skip")
                .font(.poppins(.medium, size: 17))
                .foregroundStyle(.black.opacity(0.5))
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .safeAreaPadding(.horizontal, 16)
    }
}
