//
//  addItemView.swift
//  Kahera
//
//  Created by Vincio on 8/6/21.
//

import SwiftUI
import SFSymbolsPicker

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Inventory.entity(), sortDescriptors: []) var inventory: FetchedResults<Inventory>
    @State private var itemName = ""
    @State private var price = ""
    @State private var barcode = ""
    @ObservedObject var cart: CartItems
    @State private var showNameAlert = false
    @State private var showBarcodeAlert = false
    @State private var showPriceAlert = false
    @State private var showQuantityAlert = false
    @State private var errorMessage = ""
    @Binding var image: String
    @State private var showPicker = false
    var body: some View {
        ZStack {
            List {
                Section(header: Text("Item Name")) {
                    TextField("", text: $itemName)
                        .alert(isPresented: $showNameAlert, content: { Alert(title: Text("Name Already Exists!"), message: Text("Enter a valid name."), dismissButton: .cancel())})
                }

                Section(header: Text("Item ID / Barcode")){
                    TextField("", text: $barcode)
                        .keyboardType(.numberPad)
                        .alert(isPresented: $showBarcodeAlert, content: { Alert(title: Text("Barcode Already Exists!"), message: Text("Enter a valid barcode."), dismissButton: .cancel())})
                }

                Section(header: Text("Price")){
                    TextField("\(cart.selectedCurrency)0.00", text: $price)
                        .modifier(NumbersAndDecimalsOnlyViewModifier(text: $price))
                        .alert(isPresented: $showPriceAlert, content: { Alert(title: Text("Invalid Input!"), message: Text("Enter a valid price."), dismissButton: .cancel())})
                        
                }
                Section(header: Text("Item Image")){
                    Button(action: {
                        withAnimation {
                            showPicker.toggle()
                        }
                    }, label: {
                                HStack {
                                    Text("Select item image:")
                                    Image(systemName: image)
                                        .padding(.leading, 15)
                                        .padding(.trailing, 15)
                                    Text("will be availble soon!")
                                        .foregroundColor(.gray.opacity(0.5))
                                }
                            })
                        .disabled(true)
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
                        .foregroundColor(itemName.isEmpty || price.isEmpty || barcode.isEmpty ? .gray.opacity(0.7) : Color(hex: "414243"))
                        .disabled(itemName.isEmpty || price.isEmpty || barcode.isEmpty ? true : false)
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
            itemsArray.insert(items.name?.lowercased() ?? "No Name", at: 0)
            itemsArray.insert(items.barcode ?? "00000", at:  0)
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

        else {
            let item = Inventory(context: self.moc)
            item.id = UUID()
            item.barcode = barcode
            item.name = itemName
            item.price = Double(price) ?? 0.00
            item.image = image

            do {
                try self.moc.save() //saves to Inventory

                self.presentationMode.wrappedValue.dismiss()
                print("saving...")
            } catch {
                print(error.localizedDescription)
                self.errorMessage = error.localizedDescription

            }
        }


    }
}

struct addItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView( cart: CartItems(), image: .constant("photo.fill.on.rectangle.fill"))
    }
}
