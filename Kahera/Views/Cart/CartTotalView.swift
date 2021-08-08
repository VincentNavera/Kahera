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
                    .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    .frame(height: 70)

                HStack {
                    Text("Total:")
                    .foregroundColor(.white)
                        .titleFont()
                    Spacer()


                    Text("₱\(String(cart.totalPrice))")
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
