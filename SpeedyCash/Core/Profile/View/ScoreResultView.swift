//
//  ScoreResultView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 05.05.2025.
//

import SwiftUI

struct ScoreResultView: View {
    
    var result: Double
    
    
    var body: some View {
        if isEmpty {
            emptyView
        } else {
            normalState
        }
    }
}

#Preview {
    ScoreResultView(result: 550)
}

extension ScoreResultView {
    
    private var emptyView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Credit Score Test")
                .font(.poppins(.medium, size: 17))
            VStack(alignment: .leading, spacing: 0) {
                Text("Know your ")
                Text("credit strength")
                    .foregroundStyle(.accentOrange)
            }
            .font(.poppins(.bold, size: 28))
            Text("Take a short test to understand your credit score and get better financial opportunities.")
                .font(.poppins(.regular, size: 14))
                .foregroundStyle(.black.opacity(0.5))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
        .background(.white, in: .rect(cornerRadius: 24))
        .overlay(alignment: .topTrailing) {
            Image(.arrowDiagonal)
                .padding()
        }
    }
    
    private var normalState: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Credit Score Test")
                .font(.poppins(.medium, size: 17))
            VStack(alignment: .leading, spacing: 4) {
                Text(result.description)
                    .font(.poppins(.bold, size: 28))
                    .foregroundStyle(.black)
                HStack(spacing: 0) {
                    Text("Your Score is ")
                        .font(.poppins(.regular, size: 14))
                        .foregroundStyle(.black.opacity(0.5))
                    Text(getCreditScoreStatus(for: Int(result)))
                        .font(.poppins(.bold, size: 14))
                }
                resultProgressView
            }
            Text("Updated on \(Date().fullDottedDate)")
                .font(.poppins(.regular, size: 14))
        }
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
        .background(.white, in: .rect(cornerRadius: 24))
        .overlay(alignment: .topTrailing) {
            Image(.arrowDiagonal)
                .padding()
        }
    }
    
    private var resultProgressView: some View {
        GeometryReader { geo in
            let offset = geo.size.width * calculateProgress()
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .fill(Color.clear)
                    .overlay {
                        Image(.scoreTestResultTreckLinear)
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(height: 38)
                Image(.testResultIndicator)
                    .offset(x: offset)
            }
        }
        .frame(height: 56)
    }
    
    private var isEmpty: Bool {
        result <= 0
    }
    
    private func getCreditScoreStatus(for score: Int) -> String {
        return Questions.scoreStatus(for: score)
    }
    
    private func calculateProgress() -> CGFloat {
        let lowerBound: CGFloat = 300
        let upperBound: CGFloat = 850
        guard !isEmpty else { return 0 }

        let clampedResult = min(max(CGFloat(result), lowerBound), upperBound)
        let progress = (clampedResult - lowerBound) / (upperBound - lowerBound)

        return progress
    }}
