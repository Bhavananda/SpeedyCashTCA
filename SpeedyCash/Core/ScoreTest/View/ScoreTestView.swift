//
//  ScoreTestView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 01.05.2025.
//

import SwiftUI
import ComposableArchitecture

struct ScoreTestView: View {
    
    @Bindable var store: StoreOf<ScoreTestFeature>
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 16) {
            HeaderWithBackButton(title: "Score Test")
            topSection
            answersList(answers: store.questionsArray[store.questionIndex].answers)
                .id(store.questionIndex)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                .animation(.easeInOut(duration: 0.3), value: store.questionIndex)
        }
        .safeAreaPadding(.horizontal, 16)
        .bgWhiteWithBlur()
        .navigationBarBackButtonHidden()
        .foregroundStyle(.black)
        .safeAreaInset(edge: .bottom) {
            nextButton
        }
        .fullScreenCover(isPresented: $store.showResultScreen.sending(\.showResultScreen)) {
            dismiss()
        }content: {
            ScoreTestResultView(score: Double(store.totalValue))
        }
    }
}

#Preview {
    ScoreTestView(store: Store(initialState: ScoreTestFeature.State(), reducer: {
        ScoreTestFeature()
    }))
}


extension ScoreTestView {
    
    private var topSection: some View {
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                pageIndicator
                testProgressView
            }
            Text(store.questionsArray[store.questionIndex].question)
                .font(.poppins(.bold, size: 17))
                .multilineTextAlignment(.center)
            
        }
        .padding(16)
        .background(.white, in: .rect(cornerRadius: 24))
    }
    
    private var pageIndicator: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Text(store.currentPageIndicationValue.description)
                .font(.poppins(.bold, size: 28))
                .foregroundStyle(.accentGreen)
                .contentTransition(.numericText())
                .animation(.default, value: store.currentPageIndicationValue)
            Text("/" + store.totalQuestionCount.description)
                .font(.poppins(.bold, size: 17))
                .foregroundStyle(.black.opacity(0.5))
            Text(" Questions")
                .font(.poppins(.medium, size: 17))
        }
    }
    
    private var testProgressView: some View {
        GeometryReader { geo in
            let width = geo.size.width * store.testProgress
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 44)
                    .fill(Color.black.opacity(0.1))
                RoundedRectangle(cornerRadius: 44)
                    .fill(Color.accentGreen)
                    .frame(width: width)
                    .animation(.default, value: store.testProgress)
            }
        }
        .frame(height: 8)
    }
    
    private func answersList(answers: [AnswerModel]) -> some View {
        VStack(spacing: 16) {
            ForEach(Array(zip(answers, answers.indices)), id: \.0.id) { (answer, index) in
                let isSelected = store.questionsArray[store.questionIndex].selectedAnswer == index
                Button {
                        store.send(.selectAnswer(index))
                } label: {
                    answerCell(answer, isSelected: isSelected)
                }
            }
        }
    }
    
    private func answerCell(_ item: AnswerModel, isSelected: Bool) -> some View {
        Text(item.answer)
            .font(.poppins(.bold, size: 17))
            .frame(maxWidth: .infinity)
            .frame(height: 62)
            .background {
                if isSelected {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(LinearGradient(
                            colors: [Color(hex: "FD8732"), Color(hex: "ECD945"), Color(hex: "78EC53"), Color(hex: "44EFA7")],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                } else {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white)
                }
            }
    }
    
    private var nextButton: some View {
        Button("Next") {
            store.send(.nextButtonTapped)
        }
        .buttonStyle(.yellow)
        .safeAreaPadding(.horizontal, 16)
        .disabled(store.continueDisabled)
    }
}
