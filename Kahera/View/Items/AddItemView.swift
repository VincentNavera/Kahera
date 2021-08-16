//
//  addItemView.swift
//  Kahera
//
//  Created by Vincio on 8/6/21.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State private var itemName = ""
    @State private var price = ""
    @State private var qty = ""
    @State private var barcode = ""
    @ObservedObject var cart: CartItems
    var body: some View {
        ZStack {
            List {
                Section(header: Text("Item Name")) {
                    TextField("", text: $itemName)
                }
                Section(header: Text("Item ID / Barcode")){
                    TextField("", text: $barcode)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("Price")){
                    TextField("\(cart.selectedCurrency)0.00", text: $price)
                        .modifier(NumbersAndDecimalsOnlyViewModifier(text: $price))
                }
                Section(header: Text("Quantity")){
                        TextField("0", text: $qty)
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
        let item = Inventory(context: self.moc)
        item.id = UUID()
        item.barcode = barcode
        item.name = itemName
        item.quantity = qty //qty type to be edited later
        item.price = Double(price) ?? 0.00

        do {
            try self.moc.save() //saves to Inventory

            self.presentationMode.wrappedValue.dismiss()
            print("saving...")
        } catch {
            print(error.localizedDescription)
        }

    }
}

struct addItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView( cart: CartItems())
    }
}
