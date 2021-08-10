//
//  TitleModifier.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct LargeTitleModifier: ViewModifier {

        func body(content: Content) -> some View {
            content
                .font(Font.system(size: 35, weight: .bold, design: .rounded))
                .foregroundColor(.black)
    }
}


extension View {
    func largeTitleFont() -> some View {
        self.modifier(LargeTitleModifier())
    }
}


struct TitleModifier: ViewModifier {

        func body(content: Content) -> some View {
            content
                .font(Font.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.black)
    }
}


extension View {
    func titleFont() -> some View {
        self.modifier(TitleModifier())
    }
}

struct DetailModifier: ViewModifier {

        func body(content: Content) -> some View {
            content
                .font(Font.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.black)
    }
}


extension View {
    func detailFont() -> some View {
        self.modifier(DetailModifier())
    }
}


struct SubtitleModifier: ViewModifier {

        func body(content: Content) -> some View {
            content
                .font(Font.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(.black)
    }
}


extension View {
    func subtitleFont() -> some View {
        self.modifier(SubtitleModifier())
    }
}







