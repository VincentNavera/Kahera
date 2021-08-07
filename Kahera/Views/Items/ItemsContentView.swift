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

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200), spacing: 10)], spacing: 34) {
                ForEach(inventory, id: \.id) { item in
                    ItemView(itemLabel: item.name ?? "No item name was given", priceLabel: item.price)
                        .onTapGesture {
                        
                        }
                }
            }.padding(.top, 40)
            .padding(.horizontal, 10)
        }
    }
}

struct ItemsContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsContentView()
    }
}
