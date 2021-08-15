//
//  ItemView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct ItemView: View {
    @Environment(\.managedObjectContext) var moc

    var itemLabel: String
    var priceLabel: Double
    @ObservedObject var cart: CartItems
    @State private var animationAmount: CGFloat = 1
    @State private var tappedCard = ""
    @State private var showActions = false
    @State private var showEditItem = false
    @Binding var showCart: Bool
    @State private var isLoading = true
    var item: Inventory

    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundColor(Color(.displayP3, red: 1, green: 1, blue: 1, opacity: 1.0))
                .frame(minWidth: 200)
                .frame(height: 110)
                .cornerRadius(24)
                .shadow(color: Color(.displayP3, red: 242/255, green: 242/255, blue: 1, opacity: 1.0), radius: 24)

            VStack(spacing: 0) {
                Image(systemName: "photo.fill.on.rectangle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 188, height: 100)
                VStack(spacing: -8) {
                    Text(itemLabel)
                        .titleFont()
                    Text("₱\(Double(priceLabel) , specifier: "%.2f")") //format to two decimal places
                        .detailFont()
                        .padding(.top, 5.0)

                }
            }
            .frame(height: 100)
            .padding(.bottom, 25)
            .padding(.horizontal, 5)
            .background(Color.clear)
        }
        .scaleEffect(animationAmount)
        .animation(.spring())
        .redacted(when: isLoading, redactionType: .customPlaceholder)
        .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 3) {

            isLoading = false}
        }

        

        .onTapGesture {
            self.showCart = true
            var currentItem = CartItemModel(name: item.name ?? "no item name", price: item.price, quantity: 1, discounted: false, barcode: item.barcode ?? "000000")

            if cart.showDiscount {
                currentItem.discounted = true
                if cart.discountedItems.contains(where: { $0.name == currentItem.name }) {

                    cart.discountedItems[cart.discountedItems.firstIndex(where: {$0.name == currentItem.name})!].quantity += 1

                } else {
                    withAnimation {
                        self.cart.discountedItems.insert(currentItem, at: 0) //adds to Cart
                    }
                }
            } else {
                if cart.items.contains(where: { $0.name == currentItem.name }) {


                    cart.items[cart.items.firstIndex(where: {$0.name == currentItem.name})!].quantity += 1

                } else {
                    withAnimation {
                        self.cart.items.insert(currentItem, at: 0) //adds to Cart
                    }
                }
            }


            animationAmount += 0.3

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                animationAmount = 1
            }
        }
        .onLongPressGesture{
            showActions.toggle()
            self.tappedCard = item.name ?? "no item name"
            print(item.id!)
        }

        .actionSheet(isPresented: $showActions) {ActionSheet(title: Text("Choose an  Action for \(tappedCard)"), buttons: [

                .destructive(Text("Delete Item")) {
                    moc.delete(item)
                    try? self.moc.save()

            },
                .default(Text("Edit Item")) {
                    self.showEditItem = true
                    print(item.id!)

            }])
        }.sheet(isPresented: $showEditItem, content: {
            EditItemView(item: item)
        })

    }
}
struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(itemLabel: "Item", priceLabel: 9999.99, cart: CartItems(), showCart: .constant(false), item: Inventory())
            .previewLayout(.sizeThatFits)


    }
}
