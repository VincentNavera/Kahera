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
            HStack {
                Image(systemName: cart.items.count == 0 && cart.discountedItems.count == 0 ? "cart" : "cart.fill")
                Text("Cart(\(cart.items.count + cart.discountedItems.count))")

            }
            .titleFont()
            Spacer()
            Button(action: emptyCart, label: {
                Image(systemName: "trash")
                    .font(Font.system(size: 24, weight: .regular))
                    .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                  })

        }
        .padding(.init(top: 50, leading: 0, bottom: 0, trailing: 20))
        .frame(height: 60)


    }
    func emptyCart() {
        withAnimation {
            cart.items = []
            cart.discountedItems = []

        }

    }
}

struct CartHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CartHeaderView(cart: CartItems())
    }
}
