//
//  CartView.swift
//  Kahera
//
//  Created by Vincio on 8/5/21.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var cart: CartItems
    var body: some View {
        VStack {
            CartHeaderView(cart: cart)
            CartContentView(cart: cart)
            Spacer()
            CheckOutView()
        }
        .background(Color(#colorLiteral(red: 0.9490603805, green: 0.9489895701, blue: 0.9697913527, alpha: 1)))
        .frame(width: 417)

    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(cart: CartItems())
            .previewLayout(.fixed(width: 400, height: 768))
    }
}
