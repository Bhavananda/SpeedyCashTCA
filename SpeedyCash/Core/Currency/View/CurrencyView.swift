//
//  CurrencyView.swift
//  SpeedyCash
//
//  Created by Bhavananda Das on 12.06.2025.
//

import SwiftUI
import ComposableArchitecture

struct CurrencyView: View {
    
    @Bindable var store: StoreOf<CurrencyFeature>
    @FocusState var text
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HeaderWithBackButton(title: "Exchange Rates")
            currencyList
        }
        .bgWhiteWithBlur()
        .safeAreaPadding(.horizontal, 16)
        .foregroundStyle(Color.black)
        .task {
            print("ShowOffersTask")
            store.send(.task)
        }
        .navigationBarBackButtonHidden()
        .hideKeyboardOnTap()
    }
    
    private var baseCurrency: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Base Currency: 🇺🇸 USD")
                .font(.poppins(.medium, size: 15))
            Text("All rates are shown in relation to \nUnited States Dollar")
                .font(.poppins(.regular, size: 14))
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .multilineTextAlignment(.leading)
        .padding(.vertical, 20)
        .padding(.horizontal)
        .background(.white)
        .clipShape(.rect(cornerRadius: 24))
    }
    
    private var currencyList: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 16) {
                baseCurrency
                currencyField
                if !store.filteredCurrencies.isEmpty {
                    ForEach(store.filteredCurrencies) { currency in
                        CurrencyCell(currency: currency)
                    }
                } else {
                    emptyState
                }
            }
        }
        .scrollIndicators(.never)
    }
    
    private var currencyField: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 10) {
                Image(.settingsCurrency)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.black)
                Text("Currency Rates")
                    .font(.poppins(.medium, size: 17))
            }
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.gray)
                    .frame(width: 16, height: 16)
                TextField("", text: $store.searchText.sending(\.textChanged), prompt: Text("Search currencies…").font(.poppins(size: 17)).foregroundStyle(.gray))
                    .focused($text)
                    .font(.poppins(size: 17))
                    .overlay(alignment: .trailing) {
                        if !store.searchText.isEmpty && text {
                            Button {
                                store.send(.textChanged(""))
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.gray)
                                    .frame(width: 16, height: 16)
                                    .padding(.trailing, 6)
                            }
                        }
                    }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.thinMaterial)
                    .background(.black.opacity(0.1))
                    .blur(radius: 2)
            }
            .clipShape(.rect(cornerRadius: 10))
        }
    }
    
    private var emptyState: some View {
        VStack(spacing: 16) {
            Text("No currencies found")
                .font(.poppins(.semiBold, size: 17))
            Text("Try a different currency code or name")
                .font(.poppins(.regular, size: 17))
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .multilineTextAlignment(.center)
        .padding(.top, 70)
    }
}

#Preview {
    CurrencyView(store: Store(initialState: CurrencyFeature.State(), reducer: { CurrencyFeature()
    }))
}
