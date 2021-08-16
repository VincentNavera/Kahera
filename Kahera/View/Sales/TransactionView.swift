//
//  TransactionView.swift
//  TransactionView
//
//  Created by Vincio on 8/14/21.
//

import SwiftUI

struct TransactionView: View {
    var transaction: Sales
    var formatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        return dateFormatter
    }
    @ObservedObject var cart: CartItems

    var body: some View {
        VStack {
            Text(formatter.string(from: transaction.wrappedDate))
            Text(transaction.wrappedCustomerName)
            List() {
                HStack {
                    Text("Item")
                    Spacer()
                    Text("Price")
                    Spacer()
                    Text("Quantity")
                    Spacer()
                }
                ForEach(transaction.itemsArray, id: \.self) { item in //alignment to be fixed
                    HStack {
                        Text(item.wrappedName)
                        Spacer()
                        Text("\(cart.selectedCurrency)\(String(item.price))")
                        Spacer()
                        Text(String(item.quantity))
                        Spacer()
                        if item.isDiscounted {
                            Text("with SC/PWD Discount")
                                .foregroundColor(.red.opacity(0.7))
                        }
                    }
                }
                Spacer()

                Text("Delivery Fee: \(cart.selectedCurrency)\(transaction.wrappedDeliveryFee)")
                Text("Tax: \(cart.selectedCurrency)\(transaction.wrappedTax)")
                Text("Taxable Sales: \(cart.selectedCurrency)\(transaction.wrappedtaxableSales)")
                Text("Tax Exempt Sales: \(cart.selectedCurrency)\(transaction.wrappedTaxExemptSales)")
                Text("Tax Exempt: \(cart.selectedCurrency)\(transaction.wrappedTaxExempt)")
                Text("SC/PWD Discount: \(cart.selectedCurrency)\(transaction.wrappedDiscount)")
                Text("TOTAL: \(cart.selectedCurrency)\(String(transaction.total))")
                    .titleFont()

            }
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(transaction: Sales(), cart: CartItems())
    }
}
