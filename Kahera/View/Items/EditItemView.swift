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
    @FetchRequest(entity: Inventory.entity(), sortDescriptors: []) var inventory: FetchedResults<Inventory>
    var item: Inventory
    @State private var itemName = ""
    @State private var price = ""
    @State private var qty = ""
    @State private var barcode = ""
    @ObservedObject var cart: CartItems
    @State private var showNameAlert = false
    @State private var showBarcodeAlert = false
    @State private var showPriceAlert = false
    @State private var showQuantityAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            List {
                Section(header: Text("Name")) {
                    TextField(item.name ?? "No Name", text: $itemName)
                        .alert(isPresented: $showNameAlert, content: { Alert(title: Text("Name Already Exists!"), message: Text("Enter a valid name."), dismissButton: .cancel())})

                }
                Section(header: Text("Item ID / Barcode")) {
                    TextField(item.barcode ?? "000000", text: $barcode)
                        .alert(isPresented: $showBarcodeAlert, content: { Alert(title: Text("Barcode Already Exists!"), message: Text("Enter a valid barcode."), dismissButton: .cancel())})
                }
                Section(header: Text("Price")) {
                        TextField("\(cart.selectedCurrency)\(String(item.price))", text: $price)
                        .modifier(NumbersAndDecimalsOnlyViewModifier(text: $price))
                        .alert(isPresented: $showPriceAlert, content: { Alert(title: Text("Invalid Input!"), message: Text("Enter a valid price."), dismissButton: .cancel())})
                }
                Section(header: Text("Quantity")) {
                    TextField(item.quantity ?? "0", text: $qty)
                        .modifier(NumbersOnlyViewModifier(text: $qty))
                        .alert(isPresented: $showQuantityAlert, content: { Alert(title: Text("Invalid Input!"), message: Text("Enter a valid quantity."), dismissButton: .cancel())})
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
                        .alert(isPresented: $showQuantityAlert, content: { Alert(title: Text("ERROR!"), message: Text(errorMessage), dismissButton: .cancel())})
                    Spacer()


                }
                .padding(50)
            }
        }
        
    }
    func saveItem() {
        var itemsArray = [String]()
        for items in inventory {
            if items.name != item.name && items.barcode != item.barcode { //excludes the selected item for the user to save with the current item name and barcode
            itemsArray.insert(items.name?.lowercased() ?? "No Name", at: 0)
            itemsArray.insert(items.barcode ?? "00000", at:  0)
            }
        }
        if itemsArray.contains(itemName.lowercased()) {
            self.showNameAlert = true
        }
        else if itemsArray.contains(barcode) {
            self.showBarcodeAlert = true

        }
        else if Double(price) == nil {
            self.showPriceAlert = true
        }
        else if Int(qty) == nil {
            self.showQuantityAlert = true
        }
        else {
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
                self.errorMessage = error.localizedDescription
            }

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
