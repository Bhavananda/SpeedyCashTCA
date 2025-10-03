//
//  OffersFeature.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 28.04.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct OffersFeature {
    
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
        var showDetail: OfferModel?
        var topOffers: [OfferModel] = []
        var normalOffers: [OfferModel] = []
    }
    
    enum Action {
        case task
        case fetchOffers
        case offersResponse([OfferModel])
        case viewAllTopTapped
        case viewAllNormalTapped
        case showDetail(OfferModel)
        case dismissDetail(OfferModel?)
        case destination(PresentationAction<Destination.Action>)
    }
    
    @Dependency(\.offersClient) var offersClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .task:
                return .send(.fetchOffers)
            case .fetchOffers:
                return .run { send in
                    do {
                        let offers = try await offersClient.fetchOffers()
                        await send(.offersResponse(offers))
                    } catch {
                        print("⚠️ Fetch offers error: \(error)")
                    }
                }
            case let .offersResponse(offers):
                print("Offers Response")
                state.normalOffers = offers.filter({!$0.topOffer}).sorted(by: { $0.order < $1.order })
                state.topOffers = offers.filter({$0.topOffer}).sorted(by: { $0.order < $1.order })
//                print(state.normalOffers)
                return .none
            case .viewAllTopTapped:
                state.destination = .top(TopOffersFeature.State())
                return .none
            case .viewAllNormalTapped:
                state.destination = .normal(NormalOffersFeature.State())
                return .none
            case let .showDetail(result):
                state.showDetail = result
                return .none
            case let .dismissDetail(result):
                state.showDetail = result
                return .none
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension OffersFeature {
    @Reducer(state: .equatable)
    enum Destination {
        case top(TopOffersFeature)
        case normal(NormalOffersFeature)
    }
}
