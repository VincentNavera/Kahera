//
//  CartContentView.swift
//  Kahera
//
//  Created by Vincio on 8/5/21.
//

import SwiftUI

struct CartContentView: View {
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Customer Name")
                        .detailFont()
                }
            }

            Section {
                ForEach(0..<10) { _ in
                    CartItemView()
                }
            }
            .frame(height: 80)

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
                    Text("₱0.00")


                }


            }
        }
    }
}

struct CartContentView_Previews: PreviewProvider {
    static var previews: some View {
        CartContentView()
    }
}
