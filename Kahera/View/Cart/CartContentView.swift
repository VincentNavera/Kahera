//
//  CartContentView.swift
//  Kahera
//
//  Created by Vincio on 8/5/21.
//

import SwiftUI

struct CartContentView: View {
    @ObservedObject var cart: CartItems //monitors the CartItems object for changes
    @State private var editName = false


    var body: some View {
        Form {
            Section {
                HStack {
                    if editName {
                        TextField(cart.customerName, text: $cart.customerName, onCommit: {self.editName = false})
                            .textFieldStyle(.roundedBorder)
                    } else {
                        Text(cart.customerName)
                            .onTapGesture {self.editName = true}

                    }
                }
                .detailFont()
            }

            Section {
                    ForEach(cart.items, id: \.id) {item in //requires to use id to dynamically display the data
                        CartItemView(cart: cart, cartItemPrice: item.price, cartItemName: item.name)
                        
                    }
                    .onDelete(perform: deleteItems)
                
            }
            


            Section {


                HStack {
                    Text("Delivery Fee")
                        .detailFont()

                    Spacer()


                    TextField("₱0.00", text: $cart.deliveryFee, onCommit: {})
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .textFieldStyle(.roundedBorder)
                }

                HStack {

                    Text("Taxable Sales: ")
                        .foregroundColor(.gray)
                        .detailFont()

                    Spacer()
                    Text("₱\(cart.taxableSales, specifier: "%.2f")")
                        .foregroundColor(.gray)

                }

                HStack {

                    Text("Tax (\(cart.taxPercentage)%):")
                        .foregroundColor(.gray)
                        .detailFont()
                    Stepper("Change the tax percentage", value: $cart.taxPercentage, in: 1...9999999) {_ in

                    }
                    .scaleEffect(0.5)
                    .labelsHidden()


                    Spacer()
                    Text("₱\(cart.tax, specifier: "%.2f")")
                        .foregroundColor(.gray)


                }
                HStack {

                    Text("Tax Exempt Sales: ")
                        .foregroundColor(.gray)
                        .detailFont()

                    Spacer()
                    Text("₱0.00")
                        .foregroundColor(.gray)


                }
                HStack {

                    Text("Tax Exemption: ")
                        .foregroundColor(.gray)
                        .detailFont()

                    Spacer()
                    Text("₱0.00")
                        .foregroundColor(.gray)

                }
                HStack {

                    Text("Discount (\(cart.discountPercentage)%): ")
                        .foregroundColor(.gray)
                        .detailFont()
                    Stepper("Change the percentage of discount", value: $cart.discountPercentage, in: 1...9999999) {_ in

                    }
                    .scaleEffect(0.5)
                    .labelsHidden()

                    Spacer()
                    Text("₱0.00")
                        .foregroundColor(.gray)

                }
                HStack {

                    Text("Cash:")
                        .detailFont()

                    Spacer()
                    TextField("₱0.00", text: $cart.cash)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .textFieldStyle(.roundedBorder)


                }
                HStack {

                    Text("Change:")
                        .detailFont()

                    Spacer()
                    Text("₱\(cart.change, specifier: "%.2f")")


                }


            }
            CartTotalView(cart: cart)
        }
    }
    func deleteItems(at offsets: IndexSet) {
        cart.items.remove(atOffsets: offsets) //deletes swiped item from cart.items array


    }
}

@available(iOS 15.0, *)
struct CartContentView_Previews: PreviewProvider {
    static var previews: some View {
        CartContentView(cart: CartItems())
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
