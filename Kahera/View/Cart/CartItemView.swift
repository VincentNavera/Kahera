import SwiftUI

struct CartItemView: View {

    @ObservedObject var cart: CartItems
    let cartItemPrice: Double
    let cartItemName: String
    let cartItemQuantity: Int
    let cartItemID: UUID
    let cartItemIndex: Int
    @State private var oldValue = 0
    @State private var newValue = 0

    @State var changeInQuantity: Int {
        didSet {
            newValue = changeInQuantity
        }
        willSet{
            oldValue = changeInQuantity
        }
    }

    @State private var quantityStepper = 0
    var body: some View {
        HStack {
            HStack(spacing: 10) {
                VStack(alignment: .leading) {
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {

                        Image(systemName: "photo.fill.on.rectangle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 107, height: 57)

                    }
                    .padding(.leading, 1)
                    Text(cartItemName)
                        .detailFont()
                        .padding(.leading)
                }

            }
            Spacer()

            VStack(alignment: .trailing, spacing: 0) {

                Stepper(value: $quantityStepper.onChange(changeInTotalPrice)) {

                }
                .scaleEffect(0.7)
                .offset(x: 45, y: -3)



                Text("₱\(Double(cartItemPrice) , specifier: "%.2f")")
                    .largeTitleFont()

                    .padding(.trailing, 10)
                Text("Quantity: x\(changeInQuantity)")
                    .foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
                    .detailFont()
                    .padding(.trailing, 10)
                Spacer()


            }

        }
        .offset(x: 0)

    }
    func changeInTotalPrice(_ value: Int) {
        changeInQuantity = cartItemQuantity + quantityStepper //changeInQuantity for display since current cart item can be deleted and will cause out of range index if it was
        if newValue > oldValue {
            self.cart.totalPrice += cartItemPrice
            cart.items[cartItemIndex].quantity += 1
        }
        else if newValue < oldValue {
            self.cart.totalPrice -= cartItemPrice
            cart.items[cartItemIndex].quantity -= 1
        }
        print(oldValue, newValue)
        withAnimation {
            if changeInQuantity == 0 {
                cart.items.removeAll {$0.id == cartItemID} //removes the item from the cart when qty reaches zero using item id
                cart.prices.remove(at: cartItemIndex) //removes item from cart prices array using cart item index
                print(cart.prices)
            }
        }



    }
}

struct CartItemView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemView(cart: CartItems(), cartItemPrice: 999.99, cartItemName: "Item Name", cartItemQuantity: 1, cartItemID: UUID(), cartItemIndex: 0, changeInQuantity: 1)
            .previewLayout(.fixed(width: 475, height: 100))
    }
}
