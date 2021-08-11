//
//  SwiftUIView.swift
//  Kahera
//
//  Created by Vincio on 8/5/21.
//

import SwiftUI

struct CartTotalView: View {
    @ObservedObject var cart: CartItems //monitors the CartItems object for changes

    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 70)

                HStack {
                    Text("Total:")
                    .foregroundColor(.white)
                        .titleFont()
                    Spacer()


                    Text("₱\(cart.totalPrice, specifier: "%.2f")")
                            .foregroundColor(.white)
                        .largeTitleFont()
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))

            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        }
        .frame(height: 93)
        .background(Color.clear)
        .onAppear{print(cart.totalPrice)}

    }
}

struct CartTotalView_Previews: PreviewProvider {
    static var previews: some View {
        CartTotalView(cart: CartItems())
    }
}
