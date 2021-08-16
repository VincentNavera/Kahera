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
    @State private var show = false
    var body: some View {

            VStack {
                if show {
                HStack {
                    Text("Delivery Fee: \(cart.selectedCurrency)\(transaction.deliveryFee, specifier: "%.2f")")
                    Spacer()
                }
                HStack {
                    Text("Tax: \(cart.selectedCurrency)\(transaction.tax, specifier: "%.2f")")
                    Spacer()
                }
                HStack {
                    Text("Taxable Sales: \(cart.selectedCurrency)\(transaction.taxableSales, specifier: "%.2f")")
                    Spacer()
                }
                HStack {
                    Text("Tax Exempt Sales: \(cart.selectedCurrency)\(transaction.taxExemptSales, specifier: "%.2f")")
                    Spacer()
                }
                HStack {
                    Text("Tax Exempt: \(cart.selectedCurrency)\(transaction.taxExempt, specifier: "%.2f")")
                    Spacer()
                }
                HStack {
                    Text("SC/PWD Discount: \(cart.selectedCurrency)\(transaction.discount, specifier: "%.2f")")
                    Spacer()
                }
                HStack {
                    Text("TOTAL: \(cart.selectedCurrency)\(transaction.total, specifier: "%.2f")")
                        .titleFont()
                    Spacer()
                }
                .padding(.top, 15)
                } else {
                    Text("Show Total")
                }
            }
            .subtitleFont()

            .frame(width: show ? 250 : 100, height: show ? 180 : 20)
            .padding()


            .overlay(VisualEffectView(style: .systemChromeMaterialDark)
                            .opacity(0.25), alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.blue.opacity(0.5), radius: 20)
            .onTapGesture {
                withAnimation(.spring()) {
                    show.toggle()
                }
            }
            .offset( show ? CGSize(width: 290, height: 209.5) : CGSize(width: 360, height: 280))

    }

}

struct TransactionTotalView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionTotalView(transaction: Sales(), cart: CartItems())
    }
}
