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


    @Published var date = Date()
    @Published var total = 0.00
    @Published var taxableSales = ""
    @Published var tax = ""
    @Published var cash = ""
    @Published var change = ""
    @Published var discount = ""
    @Published var taxExempt = ""
    @Published var customerName = ""
    @Published var taxExemptSales = ""
    @Published var deliveryFee = ""




}
