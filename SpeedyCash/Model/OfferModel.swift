//
//  OfferModel.swift
//

import Foundation

struct OfferModel: Identifiable, Codable, Hashable {
    var id: String { objectId }
    let objectId: String
    let interest: String
    let link: String
    let companyName: String
    let terms: String
    let order: Int
    let amount: String
    let topOffer: Bool
    let image: String
    let mark: String
    let description: String
}

struct OffersResponse: Codable {
  let results: [OfferModel]
}
