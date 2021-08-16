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
                    Text("Total:")
                        .titleFont()
                    Spacer()

                    Text("\(cart.selectedCurrency)\(self.cart.totalPrice, specifier: "%.2f")")
                        .titleFont()
                }

                .foregroundColor(Color(hex: "414243"))

    }
}

struct CartTotalView_Previews: PreviewProvider {
    static var previews: some View {
        CartTotalView(cart: CartItems())
    }
}
