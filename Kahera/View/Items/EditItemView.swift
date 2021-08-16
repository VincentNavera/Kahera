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
    @Environment(\.presentationMode) var presentationMode
    var item: Inventory
    @State private var itemName = ""
    @State private var price = ""
    @State private var qty = ""
    @State private var barcode = ""
    @ObservedObject var cart: CartItems
    
    var body: some View {
        ZStack {
            List {
                Section(header: Text("Name")) {
                    TextField(item.name ?? "No Name", text: $itemName)
                }
                Section(header: Text("Item ID / Barcode")) {
                    TextField(item.barcode ?? "000000", text: $barcode)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("Price")) {
                        TextField("\(cart.selectedCurrency)\(String(item.price))", text: $price)
                        .modifier(NumbersAndDecimalsOnlyViewModifier(text: $price))
                }
                Section(header: Text("Quantity")) {
                    TextField(item.quantity ?? "0", text: $qty)
                        .modifier(NumbersOnlyViewModifier(text: $qty))
                }

            }


            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()

                    Button(action: saveItem, label: {
                        Text("Save")
                    })
                        .foregroundColor(itemName.isEmpty || price.isEmpty || qty.isEmpty || barcode.isEmpty ? .gray.opacity(0.7) : Color(hex: "414243"))
                        .disabled(itemName.isEmpty || price.isEmpty || qty.isEmpty || barcode.isEmpty ? true : false)
                    Spacer()


                }
                .padding(50)
            }
        }
        
    }
    func saveItem() {
        item.barcode = barcode
        item.name = itemName
        item.quantity = qty //qty type to be edited later
        item.price = Double(price) ?? 0.00

        do {
            try self.moc.save() //saves to Inventory
            print("saving...")
            self.presentationMode.wrappedValue.dismiss()
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
                EditItemView(item: inventory, cart: CartItems())
            }
        }
    }
