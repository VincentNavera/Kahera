import SwiftUI

struct CartItemView: View {

    @ObservedObject var cart: CartItems
    let cartItemPrice: Double
    let cartItemName: String
    let cartItemQuantity: Int
    let cartItemID: UUID
    let cartItemIndex: Int

    @State var changeInQuantity: Int

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


                Stepper("", onIncrement: incrementStep, onDecrement: decrementStep)
                .scaleEffect(0.7)
                .offset(x: 45, y: -3)
                .disabled(changeInQuantity == 0 ? true : false) //disables the stepper when reaches zero to avoid multiple increment or decrement when gets clicked too fast



                Text("₱\(Double(cartItemPrice) , specifier: "%.2f")")
                    .largeTitleFont()

                    .padding(.trailing, 10)

                if cart.items.contains(where: { $0.name == cartItemName }) {

                    Text("Quantity: x\(cart.items[cart.items.firstIndex(where: {$0.name == cartItemName})!].quantity)")
                    .foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
                    .detailFont()
                    .padding(.trailing, 10)
                }
                Spacer()


            }

        }
        .offset(x: 0)

    }
    func incrementStep() {
        quantityStepper += 1

        cart.items[cartItemIndex].quantity += 1

    }
    func decrementStep() {
        quantityStepper -= 1

        cart.items[cartItemIndex].quantity -= 1

        withAnimation {
            if cart.items[cart.items.firstIndex(where: {$0.name == cartItemName})!].quantity == 0 {
                cart.items.removeAll {$0.id == cartItemID} //removes the item from the cart when qty reaches zero using item id

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
