//
//  SettingsFeature.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 28.04.2025.
//

import Foundation
import ComposableArchitecture
import MessageUI


@Reducer
struct SettingsFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
        var settingsItems: [SettingModel] = [
            SettingModel(iconName: .settingsNotification, name: "Notification", type: .notification, isSwither: true),
            SettingModel(iconName: .settingsCurrency, name: "Exchange Rates", type: .currency),
            SettingModel(iconName: .settingsTest, name: "Credit Score Test", type: .score),
            SettingModel(iconName: .settingsAnalytics, name: "Analysis", type: .analytics),
            SettingModel(iconName: .settingsRateus, name: "Rate Us", type: .rateUs),
            SettingModel(iconName: .settingsShare, name: "Feedback", type: .feedback),
            SettingModel(iconName: .settingsTerms, name: "Terms of Service", type: .terms),
            SettingModel(iconName: .settingsPolicy, name: "Privacy Policy", type: .policy)
        ]
        var webViewType: WebViewType? = nil
        var isShowingMailView: Bool = false
        var showFeedbackAlert: Bool = false
        //var result: Result<MFMailComposeResult, Error>? = nil
        var reminderIsOn: Bool = UserDefaults.standard.bool(forKey: "Reminder")
        var notificationIsOn: Bool = UserDefaults.standard.bool(forKey: "Notification")
    }
    
    enum Action {
        case destination(PresentationAction<Destination.Action>)
        case onItemTapped(SettingsCellType)
        case notificationSwitchChanged(Bool)
        case showMailView(Bool)
        case showFeedbackAlert(Bool)
        case setResult(Result<MFMailComposeResult, Error>?)
        case showWebView(WebViewType?)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .onItemTapped(let cellType):
                switch cellType {
                case .currency:
                    state.destination = .currency(CurrencyFeature.State())
                    return .none
                case .rateUs:
                    ReviewHandler.requestReview()
                    return .none
                case .feedback:
                    if MFMailComposeViewController.canSendMail() {
                        state.isShowingMailView.toggle()
                    } else {
                        state.showFeedbackAlert.toggle()
                    }
                    return .none
                case .score:
                    state.destination = .test(ScoreTestFeature.State())
                    return .none
                    
                case .analytics:
                    state.destination = .analytics(FinancialAnalyticsFeature.State())
                    return .none
                case .policy:
                    state.webViewType = .policy
                    return .none
                case .terms:
                    state.webViewType = .terms
                    return .none
                case .notification:
                    return .none
                }
            case .notificationSwitchChanged(let isOn):
                state.notificationIsOn = isOn
                UserDefaults.standard.set(isOn, forKey: "Notification")
                NotificationClass.instance.showNotificationsSettings()
                return .none

            case .destination:
                return .none
            case let .showMailView(result):
                state.isShowingMailView = result
                return .none
            case let .showFeedbackAlert(result):
                state.showFeedbackAlert = result
                return .none
            case .setResult:
                //state.result = result
                return .none
            case let .showWebView(result):
                state.webViewType = result
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension SettingsFeature {
    @Reducer(state: .equatable)
    enum Destination {
        case currency(CurrencyFeature)
        case test(ScoreTestFeature)
        case analytics(FinancialAnalyticsFeature)
        case terms
        case policy
    }
}

extension WebViewType: Identifiable {
    var id: String {
        title
    }
}
