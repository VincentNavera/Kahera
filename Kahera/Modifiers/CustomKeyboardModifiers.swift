//
//  CustomKeyboardModifiers.swift
//  CustomKeyboardModifiers
//
//  Created by Vincio on 8/16/21.
//

import Combine
import SwiftUI

public struct NumbersOnlyViewModifier: ViewModifier {

    @Binding var text: String

    public init(text: Binding<String>) {
        self._text = text
    }

    public func body(content: Content) -> some View {
        content
            .keyboardType(.numberPad)
            .onReceive(Just(text)) { newValue in
                if newValue.range(of: "^\\d+$", options: .regularExpression) != nil {
                        self.text = newValue
                    } else if !self.text.isEmpty {
                        self.text = String(newValue.prefix(self.text.count - 1))
                    }
                }
    }
}

public struct NumbersAndDecimalsOnlyViewModifier: ViewModifier {

    @Binding var text: String

    public init(text: Binding<String>) {
        self._text = text
    }

    public func body(content: Content) -> some View {
        content
            .keyboardType(.numberPad)
            .onReceive(Just(text)) { newValue in
                if newValue.range(of: "^[-]?[\\d]*(?:\\.?[\\d]*)?$", options: .regularExpression) != nil {
                        self.text = newValue
                    } else if !self.text.isEmpty {
                        self.text = String(newValue.prefix(self.text.count - 1))
                    }
                }
    }
}
