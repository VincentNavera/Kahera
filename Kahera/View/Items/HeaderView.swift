//
//  HeaderView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct HeaderView: View {
    @State private var edit = false
    @State private var title = "STORE NAME"
    @State private var showAddItem = false
    @Binding var showCart: Bool
    @ObservedObject var cart: CartItems
    var body: some View {
            ZStack {
                if !edit {
                    HStack {
                    if showCart {
                        Text("Discount")
                            .detailFont()
                            .padding(.leading, 15)
                        Toggle("With discount", isOn: $cart.showDiscount)
                            .toggleStyle(SwitchToggleStyle(tint: Color(hex: "8fbd71")))
                            .labelsHidden()
                            .padding(.trailing, 170)


                    }
                        if !showCart {
                        Spacer()
                        }
                        
                        Text(title)
                            .titleFont()
                            .onTapGesture {
                                self.edit = true
                            }
                        Spacer()
                    }
                    HStack {
                        Spacer()

                        Button(action:{self.showAddItem = true}, label: {
                            Image(systemName: "plus")
                                .font(Font.system(size: 24, weight: .regular))

                        })
                        .padding(.trailing, 15)

//                        Button(action: { }, label: {
//                            Image(systemName: "line.horizontal.3.decrease.circle")
//                                .font(Font.system(size: 24, weight: .regular))
//                        })
//                        .padding(.trailing, 15)
                    }

                } else {
                    HStack {
                        TextField(title, text: $title, onCommit: {self.edit = false})
                        Button("Done"){
                            self.edit = false
                        }
                        .padding(.trailing, 15)
                    }
                    .padding(.leading, 70)

                }
            }

            .frame(height: 60)

            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
            .sheet(isPresented: $showAddItem, content: {
                AddItemView()
            })


    }
}
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(showCart: .constant(false), cart: CartItems())
    }
}
