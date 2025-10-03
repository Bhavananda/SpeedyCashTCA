//
//  ResignKeyboardOnDragGesture.swift
//  JoyMoney
//
//  Created by Bhavananda das on 19.11.2024.
//

import SwiftUI

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged { _ in
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}
extension View {
    func dismissKeyboard() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
    
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
