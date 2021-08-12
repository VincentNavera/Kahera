//
//  CartItems.swift
//  CartItems
//
//  Created by Vincio on 8/7/21.
//

import Foundation

class CartItems: ObservableObject {
    @Published var items = [CartItemModel]()
    var totalPrice: Double {
        var array = [Double]()
        for item in items {

            array += [item.price * Double(item.quantity)]


        }
        return array.reduce(0, +)
    }




}
