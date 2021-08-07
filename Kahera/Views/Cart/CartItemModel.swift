//
//  CartItemModel.swift
//  Kahera
//
//  Created by Vincio on 8/7/21.
//

import Foundation

class CartItemModel: Identifiable {

    let id = UUID()
    let name: String
    let price: Double
    let quantity: String

    init(name: String, price: Double, quantity: String) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }

}
