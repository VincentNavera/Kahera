//
//  CartItems.swift
//  CartItems
//
//  Created by Vincio on 8/7/21.
//

import Foundation

class CartItems: ObservableObject {
    @Published var items = [CartItemModel]()
    @Published var discountedItems = [CartItemModel]()
    @Published var showDiscount = false
    var totalPriceOfItemsWithNoDiscount: Double { //total of the items with no discount
        var array = [Double]()
        for item in items {
            array += [(item.price * Double(item.quantity))]

        }
        return array.reduce(0, +)
    }

    var totalDiscountedPriceAfterDiscount: Double { //total of discounted items after discount
        return self.taxExemptSales - self.discount
    }


    var totalOfDiscountedItemsBeforeDiscount: Double { //before discount
        var array = [Double]()
        for discountedItem in discountedItems{

            array += [(discountedItem.price * Double(discountedItem.quantity))]


        }
        return array.reduce(0, +)
    }

    var totalPrice: Double { //Grand total
        return self.totalPriceOfItemsWithNoDiscount + self.totalDiscountedPriceAfterDiscount

    }




    @Published var taxPercentage = 12
    @Published var discountPercentage = 20

    @Published var date = Date()
    @Published var total = 0.00
    @Published var cash = ""
    @Published var customerName = "Customer Name"
    @Published var deliveryFee = ""

    var taxableSales: Double { //total of items (not discounted) before tax
        return self.totalPriceOfItemsWithNoDiscount - ((Double(self.taxPercentage) / 100.00) * self.totalPriceOfItemsWithNoDiscount)
    }

    var tax: Double { //total amount of tax in item which are not discounted
        return (Double(self.taxPercentage) / 100.00) * self.totalPriceOfItemsWithNoDiscount
    }



    var change: Double {
        return (Double(cash) ?? 0.00) - self.totalPrice
    }

    var discount: Double { //total amount of discount of the price before tax
        return (Double(self.discountPercentage) / 100.00) * self.taxExemptSales
    }

    var taxExempt: Double { //total of tax that was subtracted from the price of discounted items
        return (Double(self.taxPercentage) / 100.00) * self.totalOfDiscountedItemsBeforeDiscount
    }



    var taxExemptSales: Double { //total of discounted items before tax
        return self.totalOfDiscountedItemsBeforeDiscount - ((Double(self.taxPercentage) / 100.00) * self.totalOfDiscountedItemsBeforeDiscount)
    }



}
