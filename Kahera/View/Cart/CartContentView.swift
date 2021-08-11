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
    @State private var taxPercentage = 12
    @State private var discountPercentage = 20

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
                        CartItemView(cart: cart, cartItemPrice: item.price, cartItemName: item.name, cartItemQuantity: 1, cartItemID: item.id, cartItemIndex: cart.items.firstIndex(of: item)!, changeInQuantity: item.quantity)
                        
                    }
                    .onDelete(perform: deleteItems)
                
            }
            




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
                    Text("₱\(cart.totalPrice - ((Double(taxPercentage) / 100.00) * cart.totalPrice), specifier: "%.2f")")
                        .foregroundColor(.gray)

                }

                HStack {

                    Text("VAT (\(taxPercentage)%):")
                        .foregroundColor(.gray)
                        .detailFont()
                    Stepper(value: $taxPercentage, in: 1...9999999) {

                    }
                    .scaleEffect(0.5)
                    .offset(x: -95, y: 0)

                    Spacer()
                    Text("₱\((Double(taxPercentage) / 100.00) * cart.totalPrice, specifier: "%.2f")")
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

                    Text("SC/PWD Discount (\(discountPercentage)%): ")
                        .foregroundColor(.gray)
                        .detailFont()
                    Stepper(value: $discountPercentage, in: 1...9999999) {

                    }
                    .scaleEffect(0.5)
                    .offset(x: -70, y: 0)


                    Spacer()
                    Text("₱0.00")
                        .foregroundColor(.gray)

                }
                HStack {

                    Text("Cash:")
                        .detailFont()

                    Spacer()
                    TextField("₱0.00", text: $cash)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
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
    func deleteItems(at offsets: IndexSet) {
        cart.items.remove(atOffsets: offsets) //deletes swiped item from cart.items array
        cart.prices.remove(atOffsets: offsets) //deletes swiped item price from cart.prices array
        self.cart.totalPrice = cart.prices.reduce(0, +) //re-adds the prices from prices array and store it to the cart since cart.prices array has been changed
        print(cart.prices)
        print(cart.items)
    }
}

struct CartContentView_Previews: PreviewProvider {
    static var previews: some View {
        CartContentView(cart: CartItems())
    }
}
