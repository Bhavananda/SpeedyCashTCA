//
//  OffersView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 28.04.2025.
//

import SwiftUI
import ComposableArchitecture

struct OffersView: View {
    
    @Bindable var store: StoreOf<OffersFeature>
    
    var body: some View {
        WithViewStore(store, observe: {$0} ) { viewStore in
            VStack(spacing: 16) {
                TabHeader(page: .offers)
                ScrollView {
                    VStack(spacing: 24) {
                        if !viewStore.topOffers.isEmpty{
                            topSection(viewStore.topOffers)
                        }
                        if !viewStore.normalOffers.isEmpty{
                            normalOffers(viewStore.normalOffers)
                        }
                        disclaimer
                    }
                }
                .scrollIndicators(.never)
                .scrollBounceBehavior(.basedOnSize)
            }
            .safeAreaPadding(.horizontal, 16)
            .bgWhiteWithBlur()
            .foregroundStyle(.black)
            .task {
                print("ShowOffersTask")
                store.send(.task)
            }
            .fullScreenCover(item: $store.showDetail.sending(\.dismissDetail), content: { offer in
                OfferBrowserDetailScreen(urlString: offer.link)
            })
            .navigationDestination(item: $store.scope(state: \.destination?.top, action: \.destination.top)) { store in
                TopOffersView(store: store)
            }
            .navigationDestination(item: $store.scope(state: \.destination?.normal, action: \.destination.normal)) { store in
                NormalOffersView(store: store)
            }
        }
    }
}

#Preview {
    OffersView(store: Store(initialState: OffersFeature.State(), reducer: {
        OffersFeature()
    }))
}

extension OffersView {
    
    private func topSection(_ offers: [OfferModel]) -> some View {
        VStack(spacing: 16) {
            HStack(spacing: 4, content: {
                Image(.topOffers)
                Text("Top")
                    .font(.poppins(.medium, size: 17))
                Spacer(minLength: 0)
                Button {
                    store.send(.viewAllTopTapped)
                } label: {
                    Text("View All")
                }
            })
            GeometryReader { geo in
                let width = geo.size.width * 0.8
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(offers, id: \.id) { offer in
                            OfferTopCell(offer: offer)
                                .id(offer)
                                .frame(width: width)
                                .onTapGesture {
                                    store.send(.showDetail(offer))
                                }
                        }
                    }
                    .frame(height: 174)
                }
                .scrollIndicators(.never)
                .scrollBounceBehavior(.basedOnSize)
            }
            .frame(height: 174)
        }
    }
    
    private func normalOffers(_ offers: [OfferModel]) -> some View {
        VStack(spacing: 16) {
            HStack(spacing: 4, content: {
                Image(.normalOffers)
                Text("You Might Also Like")
                    .font(.poppins(.medium, size: 17))
                Spacer(minLength: 0)
                Button {
                    store.send(.viewAllNormalTapped)
                } label: {
                    Text("View All")
                }
            })
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                ForEach(offers) { offer in
                    OfferCell(offer: offer)
                        .id(offer)
                        .onTapGesture {
                            store.send(.showDetail(offer))
                        }
                }
            }
        }
    }
    
    private var disclaimer: some View {
        Text(MockData.disclaimer)
            .font(.poppins(.regular, size: 14))
            .foregroundStyle(.black.opacity(0.5))
            .padding(16)
            .background(.white, in: .rect(cornerRadius: 24))
    }
}
