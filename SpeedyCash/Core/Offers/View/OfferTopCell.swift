//
//  OfferTopCell.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 28.04.2025.
//

import SwiftUI
import Kingfisher


struct OfferTopCell: View {
    
    var offer: OfferModel
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                topSection
                middleSection
            }
            bottomSection
        }
        .padding(EdgeInsets(top: 14, leading: 16, bottom: 20, trailing: 16))
        .background{
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
        }
        
        //        }
        //        .background {
        //            Rectangle()
        //                .fill(Color.clear)
        //                .overlay {
        //                    Image(.offersCellBg)
        //                        .resizable()
        //                        .scaledToFill()
        //                        .fixedSize(horizontal: false, vertical: true)
        //                }
        //        }
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.5)
        OfferTopCell(offer: MockData.mockOffers[0])
    }
}

extension OfferTopCell {
    
    private var topSection: some View {
        HStack{
            logo
            Spacer(minLength: 0)
            Image(.arrowDiagonal)
        }
    }
    
    private var middleSection: some View {
        HStack{
            Text(offer.amount)
                .font(.poppins(.bold, size: 22))
                .foregroundStyle(.accentOrange)
            Spacer(minLength: 0)
            HStack(spacing: 2) {
                Text(offer.mark)
                    .font(.poppins(.bold, size: 17))
                Image(.starStroke)
            }
        }
    }
    
    private var bottomSection: some View {
        HStack(spacing: 4) {
            infoCell(title: "Rate", value: offer.interest)
            Divider()
                .frame(height: 33)
            infoCell(title: "Term", value: offer.terms)
        }
        .padding(EdgeInsets(top: 5.5, leading: 16, bottom: 5.5, trailing: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black.opacity(0.1), lineWidth: 1.0)
        }
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
        VStack(spacing: 4) {
            Text(title)
                .font(.poppins(.regular, size: 14))
                .foregroundStyle(.black.opacity(0.5))
            Text(value)
                .font(.poppins(.bold, size: 17))
        }
        .frame(maxWidth: .infinity)
    }
}
