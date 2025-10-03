//
//  MaskImage.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 25.07.2024.
//

import SwiftUI

struct MaskImage: View {
    var color: Color
    var image: String
    var body: some View {
        color
            .mask {
                Image(image)
                    .resizable()
                    .scaledToFit()
            }
    }
}

//#Preview {
//    MaskImage(color: .accentToxic, image: .favourites)
//}
