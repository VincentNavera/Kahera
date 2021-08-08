//
//  CartContentView.swift
//  Kahera
//
//  Created by Vincio on 8/5/21.
//

import SwiftUI

struct CartContentView: View {
    @ObservedObject var cart: CartItems //monitors the CartItems object for changes
    @State private var cash = ""

    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Customer Name")
                        .detailFont()
                }
            }

            Section {
                    ForEach(cart.items, id: \.id) {item in //requires to use id to dynamically display the data
                        CartItemView(cartItemPrice: item.price, cartItemName: item.name, cartItemQuantity: item.quantity)

                    }


            }
            .frame(height: 100)

            Section {


                HStack {
                    Text("Delivery Fee")

                        .detailFont()

                    Spacer()

                    Button(action: { }) {
                        Image(systemName: "plus.circle")
                    }.buttonStyle(PlainButtonStyle())
                }

                HStack {

                    Text("Vatable Sales: ")
                        .foregroundColor(.gray)
                        .detailFont()

                    Spacer()
                    Text("₱0.00")
                        .foregroundColor(.gray)

                }

                HStack {

                    Text("VAT (12%):")
                        .foregroundColor(.gray)
                        .detailFont()

                    Spacer()
                    Text("₱0.00")
                        .foregroundColor(.gray)


                }
                HStack {

                    Text("VAT Exempt Sales: ")
                        .foregroundColor(.gray)
                        .detailFont()

                    Spacer()
                    Text("₱0.00")
                        .foregroundColor(.gray)


                }
                HStack {

                    Text("VAT Exemption: ")
                        .foregroundColor(.gray)
                        .detailFont()

                    Spacer()
                    Text("₱0.00")
                        .foregroundColor(.gray)

                }
                HStack {

                    Text("SC/PWD Discount (20%): ")
                        .foregroundColor(.gray)

                        .detailFont()

                    Spacer()
                    Text("₱0.00")
                        .foregroundColor(.gray)

                }
                HStack {

                    Text("Cash:")
                        .detailFont()

                    Spacer()
                    TextField("₱\(cash)", text: $cash)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)


                }
                HStack {

                    Text("Change:")
                        .detailFont()

                    Spacer()
                    Text("₱\((Double(cash) ?? 0.00) - cart.totalPrice, specifier: "%.2f")")


                }


            }
        }
    }
}

struct CartContentView_Previews: PreviewProvider {
    static var previews: some View {
        CartContentView(cart: CartItems())
    }
}
