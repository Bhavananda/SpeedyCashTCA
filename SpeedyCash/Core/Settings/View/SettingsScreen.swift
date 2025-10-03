//
//  SettingsScreen.swift
//  DayApp
//
//  Created by Bhavananda das on 21.12.2023.
//

import SwiftUI
import MessageUI
import ComposableArchitecture
import WebKit

struct SettingsScreen: View {
    
    //@Environment(MainCoordinator.self) var mainCoordinator
    @Bindable var store: StoreOf<SettingsFeature>
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            TabHeader(page: .settings)
            settingsList
        })
        .bgWhiteWithBlur()
        .safeAreaPadding(.horizontal, 16)
        .foregroundStyle(Color.black)
        .navigationBarBackButtonHidden()
//        .sheet(isPresented: $store.isShowingMailView.sending(\.showMailView)) {
//            MailView(result: $store.result.sending(\.setResult))
//                }
        .alert("This feature is currently unavailable", isPresented: $store.showFeedbackAlert.sending(\.showFeedbackAlert)) {
                    Button("Ok", role: .cancel) {
                        store.send(.showFeedbackAlert(false))
                    }
                }
        .navigationDestination(item: $store.scope(state: \.destination?.analytics, action: \.destination.analytics)) { store in
            FinancialAnalysisView(store: store)
        }
        .navigationDestination(item: $store.scope(state: \.destination?.test, action: \.destination.test)) { store in
            ScoreTestView(store: store)
        }
        .navigationDestination(item: $store.scope(state: \.destination?.currency, action: \.destination.currency)) { store in
            CurrencyView(store: store)
        }
        .sheet(item: $store.webViewType.sending(\.showWebView)) { type in
            NavigationStack {
                PolicyWebView(url: type.url)
                    .navigationTitle(type.title)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Close") {
                                store.send(.showWebView(nil))
                            }
                        }
                    }
            }
        }
    }
    
    private var settingsList: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(store.settingsItems) { item in
                    Button {
                        if !item.isSwither {
                            store.send(.onItemTapped(item.type))
                        }
                    } label: {
                        SettingCell(setting: item) { result in
                            store.send(.notificationSwitchChanged(result))
                        }
                    }
                    if item.type != store.settingsItems.last?.type{
                        Divider()
                    }
                }
            }
            .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
            .background(.white, in: .rect(cornerRadius: 24))
        }
        .scrollIndicators(.never)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    SettingsScreen(store: Store(initialState: SettingsFeature.State(), reducer: {
        SettingsFeature()
    }))
}

enum WebViewType: Equatable {
    case terms
    case policy

    var url: URL {
        switch self {
        case .terms:
            return  URL(string: "https://rocksolidgraphics.website/terms.html")!
        case .policy:
            return URL(string: "https://rocksolidgraphics.website/privacy.html")!
        }
    }

    var title: String {
        switch self {
        case .terms:
            return "Terms of Service"
        case .policy:
            return "Privacy Policy"
        }
    }
}



struct PolicyWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
}
