//
//  ItemsContentView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct ItemsContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Inventory.entity(), sortDescriptors: []) var inventory: FetchedResults<Inventory>
    @StateObject var cart = CartItems() //this creates and owns the CartItems object
    @State private var animationAmount: CGFloat = 1
    @State private var tappedCard = ""
    @State private var showAddToCart = false //to be used later for add to cart animation

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200), spacing: 10)], spacing: 34) {
                ForEach(inventory, id: \.id) { item in
                    ZStack {

                        ItemView(itemLabel: item.name ?? "No item name was given", priceLabel: item.price)
                            .scaleEffect(tappedCard == item.name! ? animationAmount : 1)
                            .animation(tappedCard == item.name! ? .spring() : nil)


                    }
                    .onTapGesture {
                        self.cart.items.insert(CartItemModel(name: item.name ?? "no item name", price: item.price, quantity: "1"), at: 0)
                        self.tappedCard = item.name ?? "no item name"
                        animationAmount += 0.3
                        showAddToCart = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            animationAmount = 1
                            showAddToCart = false
                        }
                    }

                }

            }.padding(.top, 40)
            .padding(.horizontal, 10)
        }
    }
}


struct ItemsContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsContentView(cart: CartItems())
    }
}
