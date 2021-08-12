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

    @Published var taxPercentage = 12
    @Published var discountPercentage = 20

    @Published var date = Date()
    @Published var total = 0.00
    var taxableSales: Double {
        return self.totalPrice - ((Double(self.taxPercentage) / 100.00) * self.totalPrice)
    }
    var tax: Double {
        return (Double(self.taxPercentage) / 100.00) * self.totalPrice
    }
    @Published var cash = ""
    var change: Double {
       return (Double(cash) ?? 0.00) - totalPrice
    }
    @Published var discount = ""
    @Published var taxExempt = ""
    @Published var customerName = "Customer Name"
    @Published var taxExemptSales = ""
    @Published var deliveryFee = ""




}
