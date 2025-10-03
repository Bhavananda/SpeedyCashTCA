//
//  CustomSegmentedPicker.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 03.02.2025.
//

import SwiftUI

protocol SegmentedPickerEnum: Hashable, CaseIterable, RawRepresentable where RawValue == String {}

struct CustomSegmentedPicker<EnumType: SegmentedPickerEnum>: View where EnumType.AllCases: RandomAccessCollection {
    
    @Namespace private var segmentedControl
    let selected: EnumType
    let pages: [EnumType]
    let onChange: (EnumType) -> Void
    
    init(
        selected: EnumType,
        pages: [EnumType] = Array(EnumType.allCases),
        onChange: @escaping (EnumType) -> Void
    ) {
        self.selected = selected
        self.pages = pages
        self.onChange = onChange
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(pages, id: \.rawValue) { page in
                let isSelected = selected == page
                Button {
                    withAnimation {
                        onChange(page)
                    }
                } label: {
                    cell(page: page, isSelected: isSelected)
                }
                .matchedGeometryEffect(id: page, in: segmentedControl)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.accentOrange)
                .matchedGeometryEffect(id: selected, in: segmentedControl, isSource: false)
        }
        .padding(3)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black.opacity(0.1), lineWidth: 1)
        }
    }
    
    private func cell(page: EnumType, isSelected: Bool) -> some View {
        Text(page.rawValue.capitalized)
            .font(.poppins(isSelected ? .medium : .regular, size: 13))
            .foregroundStyle(isSelected ? .white : .black.opacity(0.5))
            .frame(maxWidth: .infinity)
            .frame(height: 37)
    }
}

//#Preview {
//    CustomSegmentedPicker(selected: <#T##EnumType#>, onChange: <#T##(EnumType) -> Void#>)
//}
