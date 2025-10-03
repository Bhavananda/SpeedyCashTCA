//
//  TopOffersView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 28.04.2025.
//

import SwiftUI
import ComposableArchitecture

struct TopOffersView: View {
    
    let store: StoreOf<TopOffersFeature>
    
    
    var body: some View {
        VStack(spacing: 16) {
            HeaderWithBackButton(title: "Top Offers")
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(store.topOffers) { offer in
                        OfferTopCell(offer: offer)
                    }
                }
            }
            .scrollIndicators(.never)
            .scrollBounceBehavior(.basedOnSize)
        }
        .bgWhiteWithBlur()
        .safeAreaPadding(.horizontal, 16)
        .navigationBarBackButtonHidden()
        .foregroundStyle(.black)
        .onAppear{
            store.send(.fetchOffers)
        }
    }
}

#Preview {
    TopOffersView(store: Store(initialState: TopOffersFeature.State(), reducer: {
        TopOffersFeature()
    }))
}
