//
//  EditItemView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI
import CoreData

struct EditItemView: View {
    @Environment(\.managedObjectContext) var moc // for saving later
    let inventory: Inventory
    @Binding var showEditItem: Bool //for saving later
    @State private var itemName = "Item Name"
    @State private var price = "0.00"
    @State private var qty = "0"
    @State private var id = "1"
    var body: some View {
        Form {
            Section(header: Text("Item Name")) {
                TextField("", text: $itemName)
            }
            Section(header: Text("Item ID / Barcode")){
                TextField("", text: $id)
                    .keyboardType(.numberPad)
            }
            Section(header: Text("Price")){
                    TextField("", text: $price)
                    .keyboardType(.decimalPad)
            }
            Section(header: Text("Quantity")){
                TextField("", text: $qty)
                        .keyboardType(.numberPad)
            }

        }
        .onAppear{ // a bug to be fixed
            self.itemName = self.inventory.name ?? "no name"
            self.id = self.inventory.id ?? "0000"
            self.price = "₱\(self.inventory.price)"
            self.qty = self.inventory.quantity ?? "0"

        }

        HStack {
            Spacer()
            Button(action: saveItem, label: {
                Text("Save")
            })
            Spacer()

            Button("Cancel") {
                self.showEditItem = false
            }
            Spacer()
        }
        
    }
    func saveItem() {
        let item = Inventory(context: self.moc)
        item.id = id 
        item.name = itemName
        item.quantity = qty //qty type to be edited later
        item.price = Double(price) ?? 0.00

        try? self.moc.save() //saves to Inventory
        self.showEditItem = false
        print("saving...")

    }
}

struct EditItemView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

        static var previews: some View {
            let inventory = Inventory(context: moc)
            inventory.name = "Test book"
            inventory.quantity = "Test author"
            inventory.id = "Fantasy"
            inventory.price = 0.00

            return NavigationView {
                EditItemView(inventory: inventory, showEditItem: .constant(false))
            }
        }
    }
