//
//  CartHeaderView.swift
//  Kahera
//
//  Created by Vincio on 8/5/21.
//

import SwiftUI

struct CartHeaderView: View {
    @ObservedObject var cart: CartItems //monitors the CartItems object for changes
    var body: some View {
        HStack {
            Spacer()
            Text("Cart(\(cart.items.count))")
                .titleFont()
            Spacer()
            Image(systemName: "trash")
                .font(Font.system(size: 24, weight: .regular))
                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                .onTapGesture {
                    cart.items = []
                    cart.totalPrice = 0.00
                }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .frame(height: 60)
        .padding()
        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))


    }
}

struct CartHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CartHeaderView(cart: CartItems())
    }
}
