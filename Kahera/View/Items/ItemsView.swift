//
//  ItemsView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct ItemsView: View {
    @ObservedObject var cart: CartItems //monitors the CartItems object for changes
    var body: some View {
        VStack {
            HeaderView()
            ItemsContentView(cart: cart)
        }
        .background(Color(.displayP3, red: 248/255, green: 250/255, blue: 251/255, opacity: 1.0))
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView(cart: CartItems())
            
    }
}