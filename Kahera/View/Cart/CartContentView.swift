//
//  CartContentView.swift
//  Kahera
//
//  Created by Vincio on 8/5/21.
//

import SwiftUI

struct CartContentView: View {
    @ObservedObject var cart: CartItems //monitors the CartItems object for changes
    @State private var editName = true


    var body: some View {
        Form {
            Section {
                HStack {
                    if editName {
                        TextField("Customer Name", text: $cart.customerName, onCommit: {self.editName = false})
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
                    CartItemView(cart: cart, cartItemPrice: item.price, cartItemName: item.name, discounted: false)
                        
                }
                .onDelete(perform: deleteItems)

                ForEach(cart.discountedItems, id: \.id) {item in //requires to use id to dynamically display the data
                    ZStack {
                    CartItemView(cart: cart, cartItemPrice: item.price, cartItemName: item.name, discounted: true)
                        VStack {

                            Text("less tax & discount".uppercased())
                                .titleFont()   .foregroundColor(Color.red.opacity(0.3))
//                            .padding(.init(top: 0, leading: 5, bottom: 0, trailing: 5))
//                            .background(Color.red)
//                            .clipShape(RoundedRectangle(cornerRadius: 5))

                            


                        }
                    }

                }
                .onDelete(perform: deleteDiscountedItems)
                
                
            }
            


            Section {


                HStack {
                    Text("Delivery Fee")
                        .detailFont()

                    Spacer()


                    TextField("\(cart.selectedCurrency)0.00", text: $cart.deliveryFee, onCommit: {})
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .textFieldStyle(.roundedBorder)
                }

                HStack {

                    Text("Taxable Sales: ")
                        .foregroundColor(.gray)
                        .detailFont()

                    Spacer()
                    Text("\(cart.selectedCurrency)\(cart.taxableSales, specifier: "%.2f")")
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
                    Text( "\(cart.selectedCurrency)\(cart.tax, specifier: "%.2f")")
                        .foregroundColor(.gray)


                }
                HStack {

                    Text("Tax Exempt Sales: ")
                        .foregroundColor(.gray)
                        .detailFont()

                    Spacer()
                    Text("\(cart.selectedCurrency)\(cart.taxExemptSales, specifier: "%.2f")")
                        .foregroundColor(.gray)


                }
                HStack {

                    Text("Tax Exemption: ")
                        .foregroundColor(.gray)
                        .detailFont()

                    Spacer()
                    Text("\(cart.selectedCurrency)\(cart.taxExempt, specifier: "%.2f")")
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
                    Text("\(cart.selectedCurrency)\(cart.discount, specifier: "%.2f")")
                        .foregroundColor(.gray)

                }
                HStack {

                    Text("Cash:")
                        .detailFont()

                    Spacer()
                    TextField("\(cart.selectedCurrency)0.00", text: $cart.cash)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .textFieldStyle(.roundedBorder)



                }
                .foregroundColor(cart.change > 0  ? Color(hex: "414243") : .red.opacity(0.8))
                HStack {

                    Text("Change:")
                        .detailFont()

                    Spacer()
                    Text("\(cart.selectedCurrency)\(cart.change, specifier: "%.2f")")


                }
                .foregroundColor(cart.change > 0 ? Color(hex: "414243") : .red.opacity(0.8))


            }
            CartTotalView(cart: cart)
        }
    }
    func deleteItems(at offsets: IndexSet) {
        cart.items.remove(atOffsets: offsets) //deletes swiped item from cart.items array


    }
    func deleteDiscountedItems(at offsets: IndexSet) {
        cart.discountedItems.remove(atOffsets: offsets) //deletes swiped item from cart.discountedItems array


    }
}

@available(iOS 15.0, *)
struct CartContentView_Previews: PreviewProvider {
    static var previews: some View {
        CartContentView(cart: CartItems())
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
