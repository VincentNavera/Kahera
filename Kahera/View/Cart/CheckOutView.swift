//
//  CheckOutView.swift
//  CheckOutView
//
//  Created by Vincio on 8/12/21.
//

import SwiftUI

struct CheckOutView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var cart: CartItems
    @State private var animationAmount: CGFloat = 1
    @State private var showAlert = false
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 70)
                    .foregroundColor(Color(hex: "414243"))

                HStack {
                    Text("Check Out".uppercased())
                        .largeTitleFont()
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                .foregroundColor(Color.white)

            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        }
        .frame(height: 93)
        .scaleEffect(animationAmount)
        .animation(.default)

        .onTapGesture {
            self.animationAmount += 0.3
            self.showAlert.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.animationAmount = 1

            }

        }
        .disabled(cart.items == [] && cart.discountedItems == [] ? true : false)
        .alert(isPresented: $showAlert, content: { Alert(title: Text("Confirm Purchase"), primaryButton: .default(Text("Confirm")) {

            checkOutItems()
            emptyCart()
        }, secondaryButton: .cancel() {})})

    }

    func checkOutItems() {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        let formattedDate = dateFormatter.string(from: now)
        //added a formatted date for merging, Date types wont merge apparently

        var allItems = [CartItemModel]()

        for item in cart.items {
            allItems.insert(item, at: 0)
        }

        for item in cart.discountedItems {
            allItems.insert(item, at: 0)
        }


        for item in allItems {
            let checkOutItems = CheckOutItems(context: self.moc)

            checkOutItems.name = item.name
            checkOutItems.barcode = item.barcode
            checkOutItems.price = item.price
            checkOutItems.quantity = Int16(item.quantity)
            checkOutItems.isDiscounted = item.discounted

            checkOutItems.transaction = Sales(context: self.moc)
            checkOutItems.transaction?.date = Date()
            checkOutItems.transaction?.formattedDate = formattedDate
            checkOutItems.transaction?.total = cart.totalPrice
            checkOutItems.transaction?.taxableSales = String(cart.taxableSales)
            checkOutItems.transaction?.tax = String(cart.tax)
            checkOutItems.transaction?.cash = String(cart.cash)
            checkOutItems.transaction?.change = String(cart.change)
            checkOutItems.transaction?.discount = String(cart.discount)
            checkOutItems.transaction?.taxExempt = String(cart.taxExempt)
            checkOutItems.transaction?.customerName = cart.customerName
            checkOutItems.transaction?.taxableSales = String(cart.taxExemptSales)
            checkOutItems.transaction?.deliveryFee = cart.deliveryFee

        }


        try? self.moc.save()
        print("saving...")
    }

    func emptyCart() {
        withAnimation {
            cart.items = []
            cart.discountedItems = []
            cart.customerName = "Customer Name"
           
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(cart: CartItems())
    }
}
