//
//  ScoreTestFeature.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 01.05.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ScoreTestFeature {
    
    @ObservableState
    struct State: Equatable {
        var showResultScreen: Bool = false
        var questionsArray: [QuestionModel] = Questions.questions
        var questionIndex: Int = 0
        var totalValue: Int = 0
        
        var currentPageIndicationValue: Int {
            questionIndex + 1
        }
        
        var totalQuestionCount: Int {
            questionsArray.count
        }
        
        var continueDisabled: Bool {
            questionsArray[questionIndex].selectedAnswer == nil
        }
        
        var testProgress: Double {
            guard totalQuestionCount > 0 else { return 0.0 }
            return Double(currentPageIndicationValue) / Double(totalQuestionCount)
        }
        
        fileprivate var isLastQuestion: Bool {
            questionIndex == questionsArray.count - 1
        }
    }
    
    enum Action {
        case nextButtonTapped
        case selectAnswer(Int)
        case saveResult
        case showResultScreen(Bool)
    }
    
    @Dependency(\.dataService) var dataService
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .showResultScreen(let isPresented):
                state.showResultScreen = isPresented
                return .none
            case .nextButtonTapped:
                nextButtonTapped(state: &state)
                return  .none
            case .selectAnswer(let index):
                state.questionsArray[state.questionIndex].selectedAnswer = index
                return .none
            case .saveResult:
                return .none
            }
        }
    }
    
    func nextButtonTapped(state: inout State){
        guard let selected = state.questionsArray[state.questionIndex].selectedAnswer else { return }
        
        state.totalValue += state.questionsArray[state.questionIndex].answers[selected].value
        
        if state.isLastQuestion {
            state.showResultScreen = true
            dataService.setResult(Double(state.totalValue))
//            saveResult(value: totalValue)
//            print("Test result \(totalValue)")
//            completion(totalValue)
        } else {
            state.questionIndex += 1
        }
    }
}
