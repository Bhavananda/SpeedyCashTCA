//
//  CurrencyFeatureTests.swift
//  UnitTestingSpeedyCash
//
//  Created by Bhavananda Das on 03.10.2025.
//

import XCTest
import ComposableArchitecture
@testable import SpeedyCash

@MainActor
final class CurrencyFeatureTests: XCTestCase {
    
    let mockCurrencies = [
        CurrencyModel(code: "USD", rate: 1.0),
        CurrencyModel(code: "EUR", rate: 0.9)
    ]
    
    func testFetchCurrenciesFlow() async {
        let clock = TestClock()
        let store = TestStore(initialState: CurrencyFeature.State()) {
            CurrencyFeature()
        } withDependencies: {
            $0.continuousClock = clock
            $0.currencyClient.fetchCurrencies = { self.mockCurrencies }
        }
        
        
        await store.send(.task)
        
        await store.receive(.fetchCurrencies)
        
        await clock.advance(by: .seconds(1))
        
        
        await store.receive(\.currencyResponse) {
            $0.currencyList = self.mockCurrencies
        }
        
        //        await store.finish()
    }
}
