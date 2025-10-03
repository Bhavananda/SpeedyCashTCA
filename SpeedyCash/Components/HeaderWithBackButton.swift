//
//  HeaderWithBackButton.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 31.01.2025.
//

import SwiftUI

struct HeaderWithBackButton<RightContent: View>: View {
    
//    //@Environment(MainCoordinator.self) var mainCoordinator
    @Environment(\.dismiss) var dismiss
    
    var title: String
    var type: HeaderType
    var rightContent: RightContent
    //var backTapped: () -> ()
    
    
    init(title: String, type: HeaderType = .back, @ViewBuilder rightContent: () -> RightContent) {
        self.title = title
        self.type = type
        self.rightContent = rightContent()
        //self.backTapped = backTapped
    }
    
    
    var body: some View {
        switch type {
        case .back:
            backHeader
        case .dismiss:
            dismissHeader
        }
    }
    
    private var backHeader: some View {
        HStack{
            Button("", image: .chevronLeft) {
                //backTapped()
                dismiss()
            }
            Text(title)
                .font(.poppins(.medium, size: 17))
                .foregroundStyle(Color.black)
                .multilineTextAlignment(.center)
            Spacer(minLength: 0)
            rightContent
        }
    }
    
    private var dismissHeader: some View {
        ZStack {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 50)
            HStack{
                Spacer()
                Button("", image: .xmark) {
                   // backTapped()
                    dismiss()
                }
            }
        }
    }
    
    enum HeaderType {
        case back
        case dismiss
    }
}

extension HeaderWithBackButton where RightContent == EmptyView {
    init(title: String, type: HeaderWithBackButton.HeaderType = .back) {
        self.init(title: title, type: type) {
            EmptyView()
        }
    }
}

#Preview {
    HeaderWithBackButton(title: "Sda"){}
}
