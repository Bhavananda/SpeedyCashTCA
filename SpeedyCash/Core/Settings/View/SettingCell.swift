//
//  SettingCell.swift
//  DayApp
//
//  Created by Bhavananda das on 21.12.2023.
//

import SwiftUI

struct SettingCell: View {
    var setting: SettingModel
    var imageData: Data? = nil
    var switchHandler: (Bool) -> Void = { _ in }
    @State var isOn: Bool = false
    var body: some View {
        HStack(spacing: 16){
            Image(setting.iconName)
            Text(setting.name)
                .font(.poppins(.medium, size: 17))
                .multilineTextAlignment(.leading)
            Spacer()
            if setting.isSwither {
                if #available(iOS 17.0, *){
                    Toggle("", isOn: $isOn)
                        .onChange(of: isOn) { oldValue, newValue in
                            switchHandler(newValue)
                        }
                }else{
                    Toggle("", isOn: $isOn)
                        .onChange(of: isOn, perform: { value in
                            switchHandler(value)
                        })
                }
            } else {
                Image(.arrowDiagonal)
            }
        }
    }
}

//#Preview {
//    SettingCell()
//}
