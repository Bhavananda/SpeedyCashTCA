//
//  OffersClient.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 28.04.2025.
//

import Foundation
import ComposableArchitecture

struct OffersClient {
    var fetchOffers: () async throws -> [OfferModel]
}


extension OffersClient: DependencyKey {
    static let liveValue = OffersClient(
           fetchOffers: {
               guard let url = URL(string: "https://parseapi.back4app.com/classes/SpeedyCashAndriy") else {
                   throw URLError(.badURL)
               }
               
               var request = URLRequest(url: url)
               request.setValue("3ABoU5G6Ia3VkffPilBYkB6gw5aTisYUtR9sjddx", forHTTPHeaderField: "X-Parse-Application-Id")
               request.setValue("iJ6SnaAXYLFlju9tbGiiE4UKq3hs6OICLlVcombw", forHTTPHeaderField: "X-Parse-REST-API-Key")
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               request.httpMethod = "GET"
               
               let (data, _) = try await URLSession.shared.data(for: request)
               let decodedResponse = try JSONDecoder().decode(OffersResponse.self, from: data)
               return decodedResponse.results
           }
       )
}


extension DependencyValues {
    var offersClient: OffersClient {
        get { self[OffersClient.self] }
        set { self[OffersClient.self] = newValue }
    }
}
