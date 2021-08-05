//
//  EditItemView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct EditItemView: View {
    @State private var itemName = "Item Name"
    @State private var price = "0.00"
    @State private var qty = "0"
    @State private var id = "1"
    var body: some View {
        Form {
            Section(header: Text("Item Name")) {
                TextField(itemName, text: $itemName)
            }
            Section(header: Text("Item ID / Barcode")){
                TextField("₱\(id)", text: $id)
                    .keyboardType(.numberPad)
            }
            Section(header: Text("Price")){
                TextField(price, text: $price)
                    .keyboardType(.decimalPad)
            }
            Section(header: Text("Quantity")){
                    TextField(qty, text: $qty)
                        .keyboardType(.numberPad)
            }

        }
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView()
    }
}
