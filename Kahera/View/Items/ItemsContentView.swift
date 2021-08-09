//
//  ItemsContentView.swift
//  Kahera
//
//  Created by Vincio on 8/3/21.
//

import SwiftUI

struct ItemsContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Inventory.entity(), sortDescriptors: []) var inventory: FetchedResults<Inventory>
    @StateObject var cart = CartItems() //this creates and owns the CartItems object
    @State private var animationAmount: CGFloat = 1
    @State private var tappedCard = ""
    @State private var showAddToCart = false //to be used later for add to cart animation
    @State private var prices = [Double]()
    @State private var showActions = false
    @State private var showEditItem = false
    


    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200), spacing: 10)], spacing: 34) {
                ForEach(inventory, id: \.id) { item in
                    ZStack {

                        ItemView(itemLabel: item.name ?? "No item name was given", priceLabel: item.price)
                            .scaleEffect(tappedCard == item.name! ? animationAmount : 1)
                            .animation(tappedCard == item.name! ? .spring() : nil)
                        //action sheet popover position bug to be fixed
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
                                EditItemView(inventory: item) //different item gets passed problem to be fixed 
                            })



                    }

                    .onTapGesture {

                        self.cart.items.insert(CartItemModel(name: item.name ?? "no item name", price: item.price, quantity: "1"), at: 0) //adds to Cart

                        self.tappedCard = item.name ?? "no item name" // to single out scale effect animation

                        animationAmount += 0.3
                        showAddToCart = true //for later

                        prices += [item.price] //to store prices of the items added to cart; to get the total price
                        print(prices)

                        self.cart.totalPrice = prices.reduce(0, +) //adds the prices from prices array and store it to the cart object

                        print(cart.totalPrice)



                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            animationAmount = 1
                            showAddToCart = false
                        }
                    }
                    .onLongPressGesture{
                        showActions = true
                        self.tappedCard = item.name ?? "no item name"
                        print(item.id!)
                    }



                }

            }.padding(.top, 40)
            .padding(.horizontal, 10)



        }
    }
}


struct ItemsContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsContentView(cart: CartItems())
    }
}
