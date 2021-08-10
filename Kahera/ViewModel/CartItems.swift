//
//  CartItems.swift
//  CartItems
//
//  Created by Vincio on 8/7/21.
//

import Foundation

class CartItems: ObservableObject {
    @Published var items = [CartItemModel]()
    @Published var totalPrice = 0.00

    @Published var prices = [Double]()



}
