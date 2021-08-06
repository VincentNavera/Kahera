//
//  addItemView.swift
//  Kahera
//
//  Created by Vincio on 8/6/21.
//

import SwiftUI

struct addItemView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Inventory.entity(), sortDescriptors: []) var inventory: FetchedResults<Inventory>
    @State private var itemName = ""
    @State private var price = ""
    @State private var qty = ""
    @State private var id = ""
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Item Name")) {
                    TextField("", text: $itemName)
                }
                Section(header: Text("Item ID / Barcode")){
                    TextField("id", text: $id)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("Price")){
                    TextField("₱\(price)", text: $price)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Quantity")){
                        TextField(qty, text: $qty)
                            .keyboardType(.numberPad)
                }

            }

            Button(action: saveItem, label: {
                Text("Save")
            })
        }
    }
    func saveItem() {
        let item = Inventory(context: self.moc)
        item.id = id
        item.name = itemName
        item.quantity = qty
        item.price = Double(price) ?? 0.00

        try? self.moc.save()
        print("saving...")

    }
}

struct addItemView_Previews: PreviewProvider {
    static var previews: some View {
        addItemView()
    }
}
