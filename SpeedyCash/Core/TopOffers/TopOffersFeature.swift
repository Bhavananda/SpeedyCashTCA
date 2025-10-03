//
//  TopOffersFeature.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 07.05.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct TopOffersFeature {
    
    @ObservableState
    struct State: Equatable {
        //@Presents var destination: Destination.State?
        var topOffers: [OfferModel] = []
        //var normalOffers: [OfferModel] = []
    }
    
    enum Action {
        case fetchOffers
        case offersResponse([OfferModel])
    }
    
    @Dependency(\.offersClient) var offersClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchOffers:
                return .run { send in
                    await send(.offersResponse(
                        try await offersClient.fetchOffers()
                    ))
                }
            case let .offersResponse(offers):
                state.topOffers = offers.filter({$0.topOffer}).sorted(by: { $0.order < $1.order })
                return .none
            }
        }
    }
}
