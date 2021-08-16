//
//  HeaderView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct HeaderView: View {
    @State private var edit = false
    @State private var title = ""
    var name: String {
        return UserDefaults.standard.string(forKey: "Title") ?? "Store Name"
    }
    @State private var showAddItem = false
    @Binding var showCart: Bool
    @ObservedObject var cart: CartItems
    var body: some View {
            ZStack {
                if !edit {
                    HStack {
                    if showCart {
                        Text("SC/PWD Discount")
                            .detailFont()
                            .padding(.leading, 15)
                        Toggle("With senior citizen/PWD discount", isOn: $cart.showDiscount)
                            .toggleStyle(SwitchToggleStyle(tint: Color(hex: "8fbd71")))
                            .labelsHidden()
                            .padding(.trailing, 170)


                    }
                        if !showCart {
                        Spacer()
                        }
                        
                        Text(name)
                            .titleFont()
                        Button(action:{self.edit = true}, label: {
                            Image(systemName: "pencil")
                                .font(Font.system(size: 20, weight: .regular))
                                .foregroundColor(.gray.opacity(0.5))
                        })

                        Spacer()
                    }
                    HStack {
                        Spacer()

                        Button(action:{self.showAddItem = true}, label: {
                            Image(systemName: "plus")
                                .font(Font.system(size: 24, weight: .regular))

                        })
                        .padding(.trailing, 15)

                        Picker(cart.selectedCurrency, selection: $cart.selectedCurrency) {
                            ForEach(cart.currencies, id: \.self) { currency in
                                    Text(String(currency))

                                
                                }
                        }
    //                    .colorInvert()
                        .colorMultiply(Color(hex: "414243"))
                        .scaleEffect(1.5)
                        .padding(.trailing, 15)
                        .pickerStyle(MenuPickerStyle())

//                        Button(action: { }, label: {
//                            Image(systemName: "line.horizontal.3.decrease.circle")
//                                .font(Font.system(size: 24, weight: .regular))
//                        })
//                        .padding(.trailing, 15)
                    }

                } else {
                    HStack {
                        TextField(name, text: $title, onCommit: {self.edit = false; saveStoreName()})
                        Button("Done"){
                            self.edit = false
                            saveStoreName()
                        }
                        .padding(.trailing, 15)
                    }
                    .padding(.leading, 70)

                }
            }

            .frame(height: 60)

            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
            .sheet(isPresented: $showAddItem, content: {
                AddItemView(cart: cart, image: .constant("photo.fill.on.rectangle.fill"))
            })


    }
    func saveStoreName() {
        UserDefaults.standard.set(self.title, forKey: "Title")

    }


}
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(showCart: .constant(false), cart: CartItems())
    }
}
