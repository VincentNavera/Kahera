//
//  ItemsContentView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct ItemsContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Inventory.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Inventory.name, ascending: true),]) var inventory: FetchedResults<Inventory>
    @StateObject var cart = CartItems() //this creates and owns the CartItems object
    @Binding var showCart: Bool
    @State private var isLoading = true
    
    


    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200), spacing: 10)], spacing: 34) {
                ForEach(inventory, id: \.id) { item in
                    ZStack {

                        ItemView(itemLabel: item.name ?? "No item name was given", priceLabel: item.price, barcodeLabel: item.barcode ?? "00000", cart: cart, showCart: $showCart, item: item)
                            .redacted(when: isLoading, redactionType: .customPlaceholder)
                            .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 1) {isLoading = false}
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
        ItemsContentView(cart: CartItems(), showCart: .constant(false))
    }
}
