//
//  CurrencyService.swift
//  SpeedyCash
//
//  Created by Bhavananda Das on 12.06.2025.
//

import Foundation
import ComposableArchitecture

struct CurrencyClient {
    var fetchCurrencies: @Sendable () async throws -> [CurrencyModel]
}


extension CurrencyClient: DependencyKey {
    static let liveValue = CurrencyClient(
        fetchCurrencies: {
            guard let url = URL(string: "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/usd.json") else {
                throw URLError(.badURL)
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            
            if let prettyString = String(data: prettyData, encoding: .utf8) {
                print("🌈 JSON (pretty):\n\(prettyString)")
            }
            
            let decodedResponse = try JSONDecoder().decode(CurrencyResponse.self, from: data)
            let models = decodedResponse.usd.map { CurrencyModel(code: $0.key, rate: $0.value) }
            return models
        }
    )
}


extension DependencyValues {
    var currencyClient: CurrencyClient {
        get { self[CurrencyClient.self] }
        set { self[CurrencyClient.self] = newValue }
    }
}
