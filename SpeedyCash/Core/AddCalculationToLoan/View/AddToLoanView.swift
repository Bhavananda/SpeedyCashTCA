//
//  AddToLoanView.swift
//  SpeedyCash
//
//  Created by Bhavananda das on 30.04.2025.
//

import SwiftUI
import ComposableArchitecture

struct AddToLoanView: View {
    
    @Binding var loanName: String
    @Binding var loanIcon: String
    @Binding var isPresented: Bool
    
    @State private var showSuccessAlert = false
    
    var onSave: () -> Void
    var body: some View {
        ZStack(alignment: .top) {
            Color.bgWhite.ignoresSafeArea()
            VStack(spacing: 16) {
                HeaderWithBackButton(title: "Add to Loans", type: .dismiss)
                ScrollView {
                    VStack(spacing: 24) {
                        nameTextField
                        LoanIconPickerView(icon: $loanIcon)
                    }
                }
            }
            .safeAreaPadding(16)
        }
        .hideKeyboardOnTap()
        .safeAreaInset(edge: .bottom) {
            saveButton
        }
        .overlay {
            if showSuccessAlert {
                AppAlertView(type: .savedToLoan) {
                    isPresented = false
                    onSave()
                }
            }
        }
    }
}

//#Preview {
//    AddToLoanView(store: Store(initialState: AddToLoanFeature.State(), reducer: {
//        AddToLoanFeature()
//    }))
//}


extension AddToLoanView {
    private var nameTextField: some View {
        VStack(spacing: 4) {
            Text("Loan Name")
                .font(.poppins(.medium, size: 17))
            TextField(
                "",
                text: $loanName ,
                prompt: Text("e.g. Home, Car, Education").foregroundStyle(.black.opacity(0.5))
            )
            .multilineTextAlignment(.center)
            .padding(EdgeInsets(top: 9, leading: 16, bottom: 9, trailing: 16))
            .background(.white, in: .rect(cornerRadius: 24))
        }
    }
    
    private var saveButton: some View {
        Button("Save") {
            showSuccessAlert = true
        }
        .buttonStyle(.yellow)
        .safeAreaPadding(16)
        .disabled(loanName.isEmpty || loanIcon.isEmpty)
    }
}
