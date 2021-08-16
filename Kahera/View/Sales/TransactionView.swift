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
                    HStack {
                        Text("Item")
                        Spacer()
                    }

                    HStack {
                        Text("Price")
                        Spacer()
                    }

                    HStack {
                        Text("Quantity")
                        Spacer()
                    }

                }
                ForEach(transaction.itemsArray, id: \.self) { item in //alignment to be fixed
                    HStack {

                        if item.isDiscounted {
                            HStack {
                                Text("\(cart.selectedCurrency)\(String(item.price))")
                                Text("with SC/PWD Discount")
                                    .font(Font.system(size: 10, weight: .bold, design: .rounded))
                                    .foregroundColor(.red.opacity(0.7))
                                Spacer()
                            }
                        } else {
                            HStack {
                                Text(item.wrappedName)
                                Spacer()
                            }

                        }
                        
                        HStack {
                            Text("\(cart.selectedCurrency)\(String(item.price))")
                            Spacer()
                        }

                        HStack {
                            Text(String(item.quantity))
                            Spacer()
                        }


                    }
                }
            }
            TransactionTotalView(transaction: transaction, cart: cart)
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(transaction: Sales(), cart: CartItems())
    }
}
