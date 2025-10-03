//
//  GaugeView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 10.04.2025.
//

import SwiftUI

struct GaugeView: View {
    let progressRange = 300.0...850.0
    let minAngle: Double = 180  // Кут для мінімального значення
    let maxAngle: Double = 360   // Кут для максимального значення
    
    @State private var progress: Double
    //private var progressInitValue: Double
    
    init(progress: Double) {
        _progress = State(initialValue: progress)
        //progressInitValue = progress
    }
    
    var angle: Double {
        let clampedProgress = min(max(progress, progressRange.lowerBound), progressRange.upperBound)
        let normalized = (clampedProgress - progressRange.lowerBound) / (progressRange.upperBound - progressRange.lowerBound)
        
        // Кут збільшується за годинниковою стрілкою (270°)
        return minAngle + normalized * (maxAngle - minAngle) + 90
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Image(.testResultBg) // Ваше зображення градієнта
                    .resizable()
                    .scaledToFit()
                HStack{
                    Text(progressRange.lowerBound.intDescription)
                    Spacer()
                    Text(progressRange.upperBound.intDescription)
                }
                .font(.poppins(.regular, size: 17))
                .foregroundStyle(.black.opacity(0.5))
            }
            
            
            ArrowView(angle: angle)
                .frame(width: 150, height: 150)
            
                .offset(y: 25)
                .overlay(alignment: .bottom) {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 25, height: 25)
                        //.offset(y: 12.5)
                }
                
        }
        
        //.frame(width: 300, height: 142)
        //        .onAppear {
        //            withAnimation(.easeInOut(duration: 1.0)) {
        //                progress = progressInitValue
        //            }
        //        }
    }
}

struct ArrowView: View {
    var angle: Double

    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)

            Triangle()
                .fill(Color.black)
                .frame(width: size * 0.1, height: size * 0.5) // Довга і тонка стрілка
                .rotationEffect(.degrees(angle), anchor: .bottom)
                .position(x: size / 2, y: size / 2)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // Верхня вершина — гострий кінець
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        // Лівий нижній кут
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        // Правий нижній кут
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    GaugeView(progress: 600)
}
