//
//  OfferCell.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 28.04.2025.
//

import SwiftUI
import Kingfisher

struct OfferCell: View {
    
    var offer: OfferModel
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            topSection
            VStack(alignment: .leading, spacing: 4) {
                sumTitle
                infoCell(title: "Rate", value: offer.interest)
                infoCell(title: "Term", value: offer.terms)
            }
        }
        .padding(16)
        .background(.white, in: .rect(cornerRadius: 24))
    }
}

#Preview {
    OfferCell(offer: MockData.mockOffers[0])
}

extension OfferCell {
    
    private var topSection: some View {
        HStack{
            logo
            Spacer(minLength: 0)
            Image(.arrowDiagonal)
        }
    }
    
    private var sumTitle: some View {
        Text(offer.amount)
            .foregroundStyle(.accentOrange)
            .font(.poppins(.bold, size: 22))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var logo: some View {
        KFImage(URL(string: offer.image))
            .placeholder{
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
            .cacheMemoryOnly()
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .frame(height: 40)
            .frame(maxWidth: .infinity, alignment: .leading)
            .safeAreaPadding(.horizontal, 16)
    }
    
    private func infoCell(title: String, value: String) -> some View {
        HStack(spacing: 0) {
            Text(title + " ")
                .font(.poppins(.regular, size: 14))
                .foregroundStyle(.black.opacity(0.5))
            Text(value)
                .font(.poppins(.bold, size: 14))
        }
    }
}
