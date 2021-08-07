//
//  customTransition.swift
//  customTransition
//
//  Created by Vincio on 8/8/21.
//

import SwiftUI

extension AnyTransition {
    static var moveAndScale: AnyTransition {
        AnyTransition.move(edge: .leading).combined(with: .scale)
    }
}
