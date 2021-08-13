//
//  TabItemsView.swift
//  TabItemsView
//
//  Created by Vincio on 8/13/21.
//

import SwiftUI

struct TabItemsView: View {
    @ObservedObject var cart: CartItems
    @Binding var showCart: Bool
    var body: some View {

        TabView {
            ItemsView(cart: cart, showCart: $showCart)
            .tabItem {
              Label("Inventory", systemImage: "")
            }
            .animation(.default)

          Text("Records Here")
            .tabItem {
              Label("Sales", systemImage: "")
            }


        }
        .accentColor(Color(hex: "414243"))
    }
}

struct TabItemsView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemsView(cart: CartItems(), showCart: .constant(false))
    }
}
