import SwiftUI

struct CartItemView: View {

    @ObservedObject var cart: CartItems
    let cartItemPrice: Double
    let cartItemName: String
    @State private var animationAmount: CGFloat = 1
    let discounted: Bool

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


                Stepper("Change the number of item quantity", onIncrement: incrementStep, onDecrement: decrementStep)
                .scaleEffect(0.7)
                .offset(x: 23, y: -3)
                .labelsHidden()
                .disabled(cart.discountedItems.contains(where: { $0.name == cartItemName }) && cart.discountedItems[cart.discountedItems.firstIndex(where: {$0.name == cartItemName})!].quantity == 0 ? true : false) //disables the stepper when reaches zero to avoid multiple increment or decrement when gets clicked too fast



                Text("₱\(Double(cartItemPrice) , specifier: "%.2f")")
                    .largeTitleFont()

                    .padding(.trailing, 10)
                if discounted {
                    if cart.discountedItems.contains(where: { $0.name == cartItemName }) {

                        Text("Quantity: x\(cart.discountedItems[cart.discountedItems.firstIndex(where: {$0.name == cartItemName})!].quantity)")
                        .foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
                        .detailFont()
                        .padding(.trailing, 10)
                        .scaleEffect(animationAmount)
                        .animation(.default)
                    }

                } else {

                    if cart.items.contains(where: { $0.name == cartItemName }) {

                        Text("Quantity: x\(cart.items[cart.items.firstIndex(where: {$0.name == cartItemName})!].quantity)")
                        .foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
                        .detailFont()
                        .padding(.trailing, 10)
                        .scaleEffect(animationAmount)
                        .animation(.default)
                    }
                }
                Spacer()


            }

        }
        .offset(x: 0)


    }
    func incrementStep() {
        if discounted {
            cart.discountedItems[cart.discountedItems.firstIndex(where: {$0.name == cartItemName})!].quantity += 1
        } else {
            cart.items[cart.items.firstIndex(where: {$0.name == cartItemName})!].quantity += 1
        }
        animationAmount += 0.3
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.animationAmount = 1
        }

    }
    func decrementStep() {

        if discounted {
            cart.discountedItems[cart.discountedItems.firstIndex(where: {$0.name == cartItemName})!].quantity -= 1
            withAnimation {
                if cart.discountedItems[cart.discountedItems.firstIndex(where: {$0.name == cartItemName})!].quantity == 0 {
                    cart.discountedItems.removeAll {$0.name == cartItemName} //removes the item from the cart when qty reaches zero using item name

                }
            }
        } else {
            cart.items[cart.items.firstIndex(where: {$0.name == cartItemName})!].quantity -= 1
            withAnimation {
                if cart.items[cart.items.firstIndex(where: {$0.name == cartItemName})!].quantity == 0 {
                    cart.items.removeAll {$0.name == cartItemName} //removes the item from the cart when qty reaches zero using item name

                }
            }
        }




        animationAmount += 0.3
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.animationAmount = 1
        }



    }

}

struct CartItemView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemView(cart: CartItems(), cartItemPrice: 999.99, cartItemName: "Item Name", discounted: false)
            .previewLayout(.fixed(width: 475, height: 100))
    }
}
