//
//  ItemsView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct ItemsView: View {
    @ObservedObject var cart: CartItems //monitors the CartItems object for changes
    @Binding var showCart: Bool
    var body: some View {
        VStack {
            HeaderView(showCart: $showCart, cart: cart)
            ItemsContentView(cart: cart, showCart: $showCart)
        }

    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView(cart: CartItems(), showCart: .constant(false))
            
    }
}
