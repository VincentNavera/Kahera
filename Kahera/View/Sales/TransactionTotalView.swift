//
//  TransactionTotalView.swift
//  TransactionTotalView
//
//  Created by Vincio on 8/16/21.
//

import SwiftUI

struct TransactionTotalView: View {
    var transaction: Sales
    @ObservedObject var cart: CartItems
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Delivery Fee: \(cart.selectedCurrency)\(transaction.wrappedDeliveryFee)")
                    Spacer()
                }
                HStack {
                    Text("Tax: \(cart.selectedCurrency)\(transaction.wrappedTax)")
                    Spacer()
                }
                HStack {
                    Text("Taxable Sales: \(cart.selectedCurrency)\(transaction.wrappedtaxableSales)")
                    Spacer()
                }
                HStack {
                    Text("Tax Exempt Sales: \(cart.selectedCurrency)\(transaction.wrappedTaxExemptSales)")
                    Spacer()
                }
                HStack {
                    Text("Tax Exempt: \(cart.selectedCurrency)\(transaction.wrappedTaxExempt)")
                    Spacer()
                }
                HStack {
                    Text("SC/PWD Discount: \(cart.selectedCurrency)\(transaction.wrappedDiscount)")
                    Spacer()
                }
                HStack {
                    Text("TOTAL: \(cart.selectedCurrency)\(String(transaction.total))")
                        .titleFont()
                    Spacer()
                }
                .padding(.top, 15)
            }
            .foregroundColor(.white)

            Spacer()
        }
        .padding()
        .background(Color(hex: "414243"))
    }

}

struct TransactionTotalView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionTotalView(transaction: Sales(), cart: CartItems())
    }
}
