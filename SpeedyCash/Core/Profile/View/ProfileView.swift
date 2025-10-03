//
//  ProfileView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 05.05.2025.
//

import SwiftUI
import ComposableArchitecture

struct ProfileView: View {
    
    @Bindable var store: StoreOf<ProfileFeature>
    
    
    var body: some View {
        WithViewStore(store, observe: \.self) { viewStore in
            VStack(spacing: 16) {
                TabHeader(page: .home)
                ScrollView {
                    VStack(spacing: 24) {
                        quizCheck
                        ScoreResultView(result: store.testScore)
                        buttons
                        PaymentSummaryView(paid: store.paid, leftToPay: store.leftToPay)
                    }
                }
                .scrollIndicators(.never)
                .scrollBounceBehavior(.basedOnSize)
            }
            .foregroundStyle(.black)
            .safeAreaPadding(.horizontal, 16)
            .bgWhiteWithBlur()
            .navigationDestination(item: $store.scope(state: \.destination?.test, action: \.destination.test)) { store in
                ScoreTestView(store: store)
            }
            .navigationDestination(item: $store.scope(state: \.destination?.analysis, action: \.destination.analysis)) { store in
                FinancialAnalysisView(store: store)
            }
            .task {
                store.send(.task)
            }
        }
    }
}

#Preview {
    ProfileView(store: Store(initialState: ProfileFeature.State(), reducer: {
        ProfileFeature()
    }))
}

extension ProfileView {
    
    private var quizCheck: some View {
        Button {
            store.send(.testTapped)
        } label: {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Smart Loan Check")
                        .foregroundStyle(.white)
                        .font(.poppins(.bold, size: 17))
                    Text("Instantly analyze your loan\nterms for fairness & safety")
                        .foregroundStyle(.black)
                        .font(.poppins(.regular, size: 14))
                }
                .multilineTextAlignment(.leading)
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Check")
                        .foregroundStyle(.black)
                        .font(.poppins(.bold, size: 17))
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(.white)
                .clipShape(.capsule)
            }
            .padding(15)
            .background(.accentOrange)
            .clipShape(.rect(cornerRadius: 24))
            
        }
    }
    
    private var buttons: some View {
        HStack(spacing: 16) {
            Button {
                store.send(.testTapped)
            } label: {
                buttonCell(icon: .test, name: "Score")
            }
            
            Button {
                store.send(.analysisTapped)
            } label: {
                buttonCell(icon: .analysis, name: "Analysis")
            }
        }
    }
    
    private func buttonCell(icon: ImageResource, name: String) -> some View {
        HStack(spacing: 8) {
            Image(icon)
            Text(name)
                .font(.poppins(.medium, size: 17))
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(.white, in: .rect(cornerRadius: 24))
    }
}
