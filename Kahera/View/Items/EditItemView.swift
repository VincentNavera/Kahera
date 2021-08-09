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
    @State private var barcode = "1"
    var body: some View {
        Form {
            Section(header: Text("Item Name")) {
                TextField("", text: $itemName)
            }
            Section(header: Text("Item ID / Barcode")){
                TextField("", text: $barcode)
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
//        .onAppear{ // a bug to be fixed
//            self.itemName = self.inventory.name ?? "no name"
//            self.barcode = self.inventory.barcode ?? "0000"
//            self.price = String(self.inventory.price)
//            self.qty = self.inventory.quantity ?? "0"

//        }

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
        item.id = inventory.id
        item.barcode = barcode
        item.name = itemName
        item.quantity = qty //qty type to be edited later
        item.price = Double(price) ?? 0.00

        do {
            try self.moc.save() //saves to Inventory
            self.showEditItem = false
            print("saving...")
        } catch {
            print(error.localizedDescription)
        }

    }
}

struct EditItemView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

        static var previews: some View {
            let inventory = Inventory(context: moc)
            inventory.name = ""
            inventory.quantity = ""
            inventory.barcode = ""
            inventory.price = 0.00

            return NavigationView {
                EditItemView(inventory: inventory, showEditItem: .constant(false))
            }
        }
    }
