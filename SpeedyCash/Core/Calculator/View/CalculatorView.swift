//
//  CalculatorView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 29.04.2025.
//

import SwiftUI
import ComposableArchitecture

struct CalculatorView: View {
    
    @Bindable var store: StoreOf<CalculatorFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 16) {
                TabHeader(page: .calculator)
                CustomSegmentedPicker<LoanType>(
                    selected: viewStore.selectedPage,
                                onChange: { newValue in
                                    viewStore.send(.selectedPageChanged(newValue))
                                }
                            )
                if itemsArray.isEmpty {
                    emptyState
                } else {
                    itemsList
                }
            }
            .safeAreaPadding(.horizontal, 16)
            .bgWhiteWithBlur()
            .safeAreaInset(edge: .bottom) {
                newCalculationButton
            }
            .task {
                store.send(.onAppear)
            }
            .navigationDestination(item: $store.scope(state: \.destination?.creation, action: \.destination.creation)) { store in
                CalculationCreatingView(store: store)
            }
            .navigationDestination(
                item: $store.scope(state: \.destination?.loanDetail, action: \.destination.loanDetail)
            ) { loanStore in
                LoanDetailView(store: loanStore)
            }
            .navigationDestination(
                item: $store.scope(state: \.destination?.calculationDetail, action: \.destination.calculationDetail)
            ) { calcStore in
                CalculationDetailView(store: calcStore)
            }

        }
    }
}

#Preview {
    CalculatorView(store: Store(initialState: CalculatorFeature.State(), reducer: {
        CalculatorFeature()
    }))
}

extension CalculatorView {
    
    private var itemsList: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(itemsArray) { item in
                    switch store.selectedPage {
                    case .calculation:
                        CalculationCell(calculation: item)
                            .id(item)
                            .onTapGesture {
                                store.send(.calculationTapped(item))
                            }
                    case .loan:
                        LoanCell(loan: item)
                            .id(item)
                            .onTapGesture {
                                store.send(.loanTapped(item))
                            }
                    }
                }
            }
        }
        .scrollIndicators(.never)
        .scrollBounceBehavior(.basedOnSize)
    }
    
    @ViewBuilder
    private var emptyState: some View {
        switch store.selectedPage {
        case .calculation:
            EmptyStateView(type: .calculation)
        case .loan:
            EmptyStateView(type: .loans)
        }
    }

    private var newCalculationButton: some View {
        Button(" New Calculation") {
            store.send(.newCalculationTapped)
        }
        .buttonStyle(.yellow)
        .safeAreaPadding(16)
    }
    
    private var itemsArray: [Loan] {
        switch store.selectedPage {
        case .calculation: store.calculations
        case .loan: store.loans
        }
    }
}
