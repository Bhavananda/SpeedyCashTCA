//
//  CurrencyFeature.swift
//  SpeedyCash
//
//  Created by Bhavananda Das on 12.06.2025.
//

import Foundation
import ComposableArchitecture


@Reducer
struct CurrencyFeature {
    
    @ObservableState
    struct State: Equatable {
        var currencyList: [CurrencyModel] = []
        var searchText: String = ""
        var filteredCurrencies: [CurrencyModel] {
            guard !searchText.isEmpty else { return currencyList }
            return currencyList.filter {
                $0.code.lowercased().contains(searchText.lowercased()) ||
                $0.currencyName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    enum Action: Equatable {
        case task
        case fetchCurrencies
        case currencyResponse([CurrencyModel])
        case textChanged(String)
    }
    
    @Dependency(\.currencyClient) var currencyClient
    @Dependency(\.continuousClock) var clock
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .task:
                return .send(.fetchCurrencies)
            case .fetchCurrencies:
                return .run { send in
                    do {
                        let currencies = try await currencyClient.fetchCurrencies()
                        await send(.currencyResponse(currencies))
                    } catch {
                        print("⚠️ Fetch currencies error: \(error)")
                    }
                }
            case let .currencyResponse(currencies):
                print("----- Currencies response -----")
                print(currencies)
                state.currencyList = currencies
                return.none
            case let .textChanged(text):
                state.searchText = text
                return .none
            }
        }
    }
}
