//
//  LoanIconPickerView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 30.04.2025.
//

import SwiftUI

struct LoanIconPickerView: View {
    
    @Binding var icon: String
    
    private var categories: [LoanCategory] = [
        LoanCategory(name: "Home", icon: "loanHome"),
        LoanCategory(name: "Car", icon: "loanCar"),
        LoanCategory(name: "Medical", icon: "loanMedical"),
        LoanCategory(name: "Business", icon: "loanBusiness"),
        LoanCategory(name: "Personal", icon: "loanPersonal"),
        LoanCategory(name: "Startup", icon: "loanStartup"),
        LoanCategory(name: "Gifts", icon: "loanGifts"),
        LoanCategory(name: "Childcare", icon: "loanChildcare"),
        LoanCategory(name: "Travel", icon: "loanTravel"),
        LoanCategory(name: "Other", icon: "loanOther"),
    ]
    
    
    init(icon: Binding<String>) {
        _icon = icon
    }
    
    
    var body: some View {
        VStack(spacing: 4) {
            Text("Select An Icon")
                .font(.poppins(.medium, size: 17))
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                ForEach(categories) { category in
                    let isSelected = category.icon == icon
                    Button {
                        icon = category.icon
                    } label: {
                        iconCell(category: category, isSelected: isSelected)
                    }

                }
            }
        }
    }
}

#Preview {
    LoanIconPickerView(icon: .constant(""))
}

extension LoanIconPickerView {
    private func iconCell(category: LoanCategory, isSelected: Bool) -> some View {
        VStack(spacing: 4) {
            MaskImage(color: isSelected ? .white : .black, image: category.icon)
                .frame(width: 24, height: 24)
            Text(category.name)
                .font(.poppins(.regular, size: 14))
                .foregroundStyle(isSelected ? .white : .black)
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
        .background(isSelected ? .accentOrange : .white, in: .rect(cornerRadius: 24))
    }
}

fileprivate struct LoanCategory: Identifiable {
    var id: UUID = UUID()
    let name: String
    let icon: String
}
