//
//  NormalOffersView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 28.04.2025.
//

import SwiftUI
import ComposableArchitecture

struct NormalOffersView: View {
    let store: StoreOf<NormalOffersFeature>
    
    
    var body: some View {
        VStack(spacing: 16) {
            HeaderWithBackButton(title: "Top Offers")
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2), content: {
                    ForEach(store.topOffers) { offer in
                        OfferCell(offer: offer)
                    }
                })
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
    NormalOffersView(store: Store(initialState: NormalOffersFeature.State(), reducer: {
        NormalOffersFeature()
    }))
}
