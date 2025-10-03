//
//  CircleAngularProgressView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 18.11.2024.
//

import SwiftUI

struct CircleAngularProgressView: View {
    @State var isAnimating: Bool = false
    private let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Circle()
            .stroke(AngularGradient(colors: [.black, .black.opacity(0)], center: .center), lineWidth: 4.4)
            .frame(width: 44, height: 44)
            .rotationEffect(.degrees(270))
            .rotationEffect(.degrees(isAnimating ? 0 : 360))
            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false), value: isAnimating)
            .onReceive(timer) { _ in
                isAnimating = true
                timer.upstream.connect().cancel()
            }
    }
}

#Preview {
    CircleAngularProgressView()
}
